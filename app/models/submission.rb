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
    
    logger.info pdef
    
    #Create temp folder on S3
    
    # RuoteAMQP::WorkitemListener.new(engine)
    # wfid = engine.launch(pdef)
    # engine.wait_for(wfid)

    
  end
  
  
  def generate_process_definition
    
    infile_concat = ''
    input_files.each {|i| infile_concat += "#{i} "}
    logger.info tasks.inspect
    
    # first we need to build the process defintion directly from nested arrays.
    
    tasks1 = self.tasks
    
    
    pdef = Ruote.process_definition do
      sequence do
        
        #logger.info tasks.inspect
       
          
         
            concurrence do 
              input_files.each do |in_file|
                participant :ref => 'qips_node', :input_files => in_file
              end
            end
            
         
        
        cleanup
  
      end
  
          
    end
    
    return pdef
    
    
  end
  
  
  
end
