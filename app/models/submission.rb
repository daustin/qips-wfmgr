class Submission < ActiveRecord::Base
  
  has_many :tasks, :order => :rank
  serialize :input_files
  
  after_save :submit_job

  def task_attributes=(task_attributes)
    task_attributes.each do |attributes|
      tasks.build(attributes)
    end
  end
  
  def input_file_list=(list)
    list.each do |path|
      input_files << path
    end
  end
  
  def submit_job

    self.submission_tag = Time.now.to_i
    
    pdef = generate_process_definition

    # Create temp folder on S3
    
    RuoteAMQP::WorkitemListener.new(RuoteKit.engine)
    wfid = RuoteKit.engine.launch(pdef)
    # Ruote.engine.wait_for(wfid)

    
  end
  
  
  def generate_process_definition
    
    # need to reassign vars because self gets overwritten in Dsl
    
    in_files = self.input_files
    
    task_array = self.tasks
    out_folder = self.output_folder
    count = 0

    pdef = Ruote.process_definition do
      sequence do
        
        # now process each task, concurrently if needed
        
        task_array.each do |t|

          if t.protocol.run_concurrent
            
            if count < 1
              concurrent_iterator :merge_type => 'isolate', :on_val => "#{in_files.join(',')}", :to_var => 'v' do

                qips_node :command => '/worker/start_work', :input_files => '${v:v}', 
                :executable => "#{t.executable}", :exec_timeout => "#{t.protocol.process_timeout}",
                :args => "#{t.args}", :queue => "#{t.protocol.queue}", :output_folder => "#{out_folder}"

              end
              
              merge_outputs
            
            else
            
              concurrent_iterator :merge_type => 'isolate', :on_val => "#{in_files.join(',')}", :to_var => 'v' do

                qips_node :command => '/worker/start_work', :input_files => '${v:v}', 
                :executable => "#{t.executable}", :exec_timeout => "#{t.protocol.process_timeout}",
                :args => "#{t.args}", :queue => "#{t.protocol.queue}", :output_folder => "#{out_folder}"

              end
    
              merge_outputs
            
            end
      
            
          else
            
            if count < 1
            
              qips_node :command => '/worker/start_work', :input_files => "#{in_files.join(',')}",
              :executable => "#{t.executable}", :exec_timeout => "#{t.protocol.process_timeout}",
              :args => "#{t.args}", :queue => "#{t.protocol.queue}", :output_folder => "#{out_folder}"

              rename_outputs

            else
            
            
              qips_node :command => '/worker/start_work', :input_files => "${f:previous_output_files_joined}",
              :executable => "#{t.executable}", :exec_timeout => "#{t.protocol.process_timeout}",
              :args => "#{t.args}", :queue => "#{t.protocol.queue}", :output_folder => "#{out_folder}"

              rename_outputs
            
            end
            
          end
          
        
        count += 1  
        end
        
        console
  
      end
  
          
    end
    
    return pdef
    
    
  end
  
  
  
end
