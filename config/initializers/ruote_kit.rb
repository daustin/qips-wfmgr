require 'ruote/storage/fs_storage'
require 'ruote/part/local_participant'
require 'ruote/part/storage_participant'

RuoteKit.configure do |config|
  # make changes if needed
  #
  # config.work_directory = 'my_special_work_dir' # defaults to File.join( Dir.pwd, "work_#{RuoteKit.env}" )
  # config.workers = 2 # defaults to 1
  # config.run_engine = false # defaults to true
  # config.run_worker = true # defaults to false
  # config.mode = :transient # defaults to :file_system
end
 
# Register participants if needed

RuoteKit.engine.register_participant(/debug_log/, Ruote::RailsDebugLogParticipant)
RuoteKit.engine.register_participant(/qips_node.*/, RuoteAMQP::Participant)
# RuoteKit.engine.register_participant(/rmgr_start/, StorageParticipant)
RuoteKit.engine.register_participant(/console/, Ruote::ConsoleParticipant)
RuoteKit.engine.register_participant(/merge_outputs/, Ruote::MergeOutputsParticipant)
RuoteKit.engine.register_participant(/rename_outputs/, Ruote::RenameOutputsParticipant)
RuoteKit.engine.register_participant(/init_vars/, Ruote::InitVarsParticipant)
RuoteKit.engine.register_participant(/wait_for/, Ruote::SleeperParticipant)
RuoteKit.engine.register_participant(/request_nodes/, Ruote::RmgrRequestParticipant)

RuoteAMQP::WorkitemListener.new(RuoteKit.engine)

# Register the catchall participant (named '.*') if needed
RuoteKit.configure_catchall!