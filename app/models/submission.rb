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
    
    RuoteAMQP::WorkitemListener.new(Ruote.engine)
    wfid = Ruote.engine.launch(pdef)
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
            concurrence :merge_type => 'mix' do
              in_files.each do |i|
                
                if count > 0
                  qips_node :command => '/worker/start_work', 
                  :executable => "#{t.executable}", :args => "#{t.args}", :exec_timeout => "#{t.protocol.process_timeout}",
                  :queue => "#{t.protocol.queue}", :output_folder => "#{out_folder}"
                
                else
                  qips_node :command => '/worker/start_work', :input_files => "#{count > 0 ? nil : i}", 
                  :executable => "#{t.executable}", :args => "#{t.args}", :exec_timeout => "#{t.protocol.process_timeout}",
                  :queue => "#{t.protocol.queue}", :output_folder => "#{out_folder}"
                end
                
              end
             
            end
            # console
            merge_outputs
            
            
          else
            
            if count > 0
            
              qips_node :command => '/worker/start_work', 
              :executable => "#{t.executable}", :args => "#{t.args}", :exec_timeout => "#{t.protocol.process_timeout}",
              :queue => "#{t.protocol.queue}", :output_folder => "#{out_folder}"
            else
            
              qips_node :command => '/worker/start_work', :input_files => "#{count > 0 ? nil : in_files.join(' ')}", 
              :executable => "#{t.executable}", :args => "#{t.args}", :exec_timeout => "#{t.protocol.process_timeout}",
              :queue => "#{t.protocol.queue}", :output_folder => "#{out_folder}"
            
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
