require 'rubygems'
require 'ruote'
require 'ruote-amqp'
require 'ruote/storage/fs_storage'
 
engine = Ruote::Engine.new(Ruote::Worker.new(Ruote::FsStorage.new('work')))
# engine = OpenWFE::Engine.new(:definition_in_launchitem_allowed => true)
 
AMQP.settings[:vhost] = '/'
AMQP.settings[:user]  = 'guest'
AMQP.settings[:pass]  = 'guest'
AMQP.settings[:host] = 'localhost' # '174.129.8.254'
# AMQP.settings[:port] = 6000
AMQP.logging = true
 
pdef = Ruote.process_definition do
  sequence do
    
    concurrence do
      qips_node :command => '/worker/start_work', :input_files => 'daustin-test:subfolder1/interact_chr10_gaps.xls',
      :sqs_timeout => '20', :executable => '/opt/bin/reverse_files.sh 2>&1', :args => '10', 
      :queue => 'test', :output_folder => 'daustin-test:outputs/'
      
      qips_node :command => '/worker/start_work', :input_files => 'daustin-test:subfolder1/interact_chr11_gaps.xls',
      :sqs_timeout => '20', :executable => '/opt/bin/reverse_files.sh 2>&1', :args => '20', 
      :queue => 'test', :output_folder => 'daustin-test:outputs/'
 
    end
    qips_node :command => '/worker/start_work', :input_files => 'daustin-test:subfolder1/interact_chr12_gaps.xls',
    :sqs_timeout => '20', :executable => '/opt/bin/reverse_files.sh 2>&1', :args => '30', 
    :queue => 'test', :output_folder => 'daustin-test:outputs/'
 
    console
  end
end
 
engine.register_participant( 'qips_node', RuoteAMQP::Participant )
# engine.register_participant( 'qips_node2', RuoteAMQP::Participant )
# engine.register_participant( 'qips_node3', RuoteAMQP::Participant )
 
puts "listening..."
RuoteAMQP::WorkitemListener.new(engine)
 
engine.register_participant( 'console' ) do |workitem|
  puts workitem.to_h.inspect
end
 
 
wfid = engine.launch(pdef)
engine.wait_for(wfid)
 
