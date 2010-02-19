# config/initializers/ruote.rb
require 'ruote/part/storage_participant'
require 'ruote/storage/fs_storage'
require 'ruote/part/local_participant'
 
module Ruote
  class << self
    attr_accessor :engine
    attr_accessor :worker
    attr_accessor :work_directory
 
    def configure_participants
      raise "Engine has to be running before configuring participants!" unless engine_running?
      # register your own participants here
      self.engine.register_participant(/debug_log/, Ruote::RailsDebugLogParticipant)
      self.engine.register_participant(/qips_node.*/, RuoteAMQP::Participant)
      self.engine.register_participant(/rmgr_start/, StorageParticipant)
      self.engine.register_participant(/console/, Ruote::ConsoleParticipant)
      self.engine.register_participant(/merge_outputs/, Ruote::MergeOutputsParticipant)
      self.engine.register_participant(/rename_outputs/, Ruote::RenameOutputsParticipant)
      
    end
 
    def ensure_engine!
      run_engine! if self.engine.nil?
    end
 
    def run_engine!
      self.engine = Ruote::Engine.new( storage_instance )
      configure_participants
      self.engine
    end
 
    def engine_running?
      not self.engine.nil?
    end
 
    def shutdown_engine!
      return unless engine_running?
      shutdown_worker!
      self.engine.shutdown
    end
 
    def run_worker!(run_in_thread = false)
      self.worker = Ruote::Worker.new( storage_instance )
      run_in_thread ? self.worker.run_in_thread : self.worker.run
    end
 
    def shutdown_worker!
      return if self.worker.nil?
      self.worker.shutdown
    end
 
    def storage_participant
      return unless engine_running?
      @storage_participant ||= Ruote::StorageParticipant.new(self.engine)
    end
 
    private
 
    def storage_instance
      Ruote::FsStorage.new( self.work_directory )
    end
  end
 
  class RailsDebugLogParticipant
    include LocalParticipant
 
    attr_accessor :context
 
    def initialize(opts)
      @opts = opts
    end
 
    def consume(workitem)
      ActionController::Base.logger.debug("Got workitem:\n#{workitem.to_h.inspect}")
      reply_to_engine(workitem)
    end
 
    def cancel (fei, flavour)
      # do nothing
    end
  end
  
  class MergeOutputsParticipant
    include LocalParticipant
 
    attr_accessor :context
 
    def initialize(opts)
      @opts = opts
    end
 
    def consume(workitem)
      previous_output_files = Array.new
      ActionController::Base.logger.info("Merge Participant: \n#{workitem.to_h.inspect}")

      # Add files

      i = 0
      until (workitem.fields[i.to_s].nil?)
        v = workitem.fields[i.to_s]['output_files']
        previous_output_files = previous_output_files.concat(v)
        puts "Added #{v}"
        i = i + 1
      end
      
      # now cleanup the fields

      i = 0
      until (workitem.fields[i.to_s].nil?)
        workitem.fields.delete i.to_s
        i = i + 1
      end 
      
      workitem.fields['previous_output_files'] = previous_output_files
      workitem.fields['previous_output_files_joined'] =  previous_output_files.join(',')

      reply_to_engine(workitem)
    end
 
    def cancel (fei, flavour)
      # do nothing
    end
  end

  class RenameOutputsParticipant
    include LocalParticipant
 
    attr_accessor :context
 
    def initialize(opts)
      @opts = opts
    end
 
    def consume(workitem)
      previous_output_files = Array.new
      ActionController::Base.logger.info("Rename Participant: \n#{workitem.to_h.inspect}")

      previous_output_files = workitem.fields['output_files'] unless  workitem.fields['output_files'].nil?

      # again, cleanup

      workitem.fields.delete 'output_files'
      
      workitem.fields['previous_output_files'] = previous_output_files
      workitem.fields['previous_output_files_joined'] =  previous_output_files.join(',')
      
      reply_to_engine(workitem)
    end
 
    def cancel (fei, flavour)
      # do nothing
    end
  end

  
  class ConsoleParticipant
    include LocalParticipant
 
    attr_accessor :context
 
    def initialize(opts)
      @opts = opts
    end
 
    def consume(workitem)
      puts "Console Participant:\n#{workitem.to_h.inspect}"
      ActionController::Base.logger.info("Console Participant: \n#{workitem.to_h.inspect}")
      reply_to_engine(workitem)
    end
 
    def cancel (fei, flavour)
      # do nothing
    end
  end
  
  
  
end
 
Ruote.work_directory = File.join(RAILS_ROOT, "work_#{RAILS_ENV.downcase}")
Ruote.run_engine!
 
# make sure the engine thread lives when being a Passenger
if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    Ruote.ensure_engine! if forked
  end
  PhusionPassenger.on_event(:stopping_worker_process) do |forked|
    Ruote.shutdown_engine!
  end
end

