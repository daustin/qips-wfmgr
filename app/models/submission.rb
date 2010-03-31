class Submission < ActiveRecord::Base
  
  has_many :tasks, :order => :rank, :dependent => :destroy
  serialize :input_files
  serialize :process_definition

  def task_attributes=(task_attributes)
    puts task_attributes.inspect
    
    task_attributes.each do |attributes|
      tasks.build(attributes)
    end
  end
  
  def submit_job

    pdef = generate_process_definition
    self.process_definition = pdef
    
    # RuoteAMQP::WorkitemListener.new(RuoteKit.engine)
    wfid = RuoteKit.engine.launch(self.process_definition)
    # Ruote.engine.wait_for(wfid)

    self.fei_wfid = wfid

    save
    
  end
  
  
  def generate_process_definition
    
    # need to reassign vars because self gets overwritten in Dsl
    
    in_files = self.input_files
    
    task_array = self.tasks
    out_folder = self.output_folder
    count = 0

    pdef = Ruote.process_definition do
      sequence do
        
        #first init vars
        init_vars :input_files => "#{in_files.join(',')}"
        
        # now process each task, concurrently if needed
        
        task_array.each do |t|
          t.save
          t.reload
          if t.protocol.run_concurrent
                            
              wait_for :time => PROCESS_WAIT_TIME unless count == 0
            
              request_nodes :num_nodes => "${f:previous_output_files_size}"
            
              concurrent_iterator :merge_type => 'isolate', :on_val => "${f:previous_output_files_joined}", :to_var => 'v' do

                qips_node :command => '/worker/start_work', :input_files => '${v:v}', :params_file => "#{t.params_url}",
                :executable => "#{t.executable}", :exec_timeout => "#{t.protocol.process_timeout}", :pass_filenames => "#{t.protocol.pass_filenames}", 
                :aux_files => "#{t.aux_files.join(',') unless t.aux_files.nil?}", :args => "#{t.args}", :queue => "#{t.protocol.queue}", :output_folder => "#{out_folder}"

              end
    
              merge_outputs :task_id => "#{t.id}"

            
          else
            
            wait_for :time => PROCESS_WAIT_TIME unless count == 0

            request_nodes :num_nodes => "1"

            qips_node :command => '/worker/start_work', :input_files => "${f:previous_output_files_joined}", :params_file => "#{t.params_url}",
            :executable => "#{t.executable}", :exec_timeout => "#{t.protocol.process_timeout}", :pass_filenames => "#{t.protocol.pass_filenames}", 
            :aux_files => "#{t.aux_files.join(',') unless t.aux_files.nil?}", :args => "#{t.args}", :queue => "#{t.protocol.queue}", :output_folder => "#{out_folder}"
            

            rename_outputs :task_id => "#{t.id}"
            
          end
          
        count += 1
        end
        
        console
  
      end
  
          
    end
    
    return pdef
    
    
  end
  
  
  
end
