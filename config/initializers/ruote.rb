# config/initializers/ruote.rb
require 'ruote/part/storage_participant'
require 'ruote/storage/fs_storage'
require 'ruote/part/local_participant'
 
module Ruote
 
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
      workitem.fields['previous_output_files_size'] = previous_output_files.size

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
      workitem.fields['previous_output_files_size'] = previous_output_files.size
      
      reply_to_engine(workitem) 
    end
 
    def cancel (fei, flavour)
      # do nothing
    end
  end

  # simple shuffles a couple vars around so the rest of the workflow can use them
  class InitVarsParticipant
    include LocalParticipant
 
    attr_accessor :context
 
    def initialize(opts)
      @opts = opts
    end
 
    def consume(workitem)
      previous_output_files = Array.new

      ActionController::Base.logger.info("Init Vars: \n#{workitem.to_h.inspect}")

      previous_output_files = workitem.fields['params']['input_files'].split(',') unless  workitem.fields['params']['input_files'].nil?
      workitem.fields['previous_output_files'] = previous_output_files
      workitem.fields['previous_output_files_joined'] =  previous_output_files.join(',')
      workitem.fields['previous_output_files_size'] = previous_output_files.size
      
      reply_to_engine(workitem) 
    end
 
    def cancel (fei, flavour)
      # do nothing
    end
  end
  
  # requests nodes from rmgr
  class RmgrRequestParticipant
    include LocalParticipant
 
    attr_accessor :context
 
    def initialize(opts)
      @opts = opts
    end
 
    def consume(workitem)
      ActionController::Base.logger.info("Rmgr Request Participant: \n#{workitem.to_h.inspect}")
      
      num_nodes = workitem.fields['params']['num_nodes'] ||= 1
      
      out = `#{RMGR_CMD}#{num_nodes}`
      
      reply_to_engine(workitem)
    end
 
    def cancel (fei, flavour)
      # do nothing
    end
  end
  
  # sleeps  
  class SleeperParticipant
    include LocalParticipant
 
    attr_accessor :context
 
    def initialize(opts)
      @opts = opts
    end
 
    def consume(workitem)
      ActionController::Base.logger.info("Sleeper Participant: \n#{workitem.to_h.inspect}")

      seconds = workitem.fields['params']['time'] ||= 10
      puts "Sleeper is sleeping for #{seconds} seconds... "
      sleep seconds

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
 

