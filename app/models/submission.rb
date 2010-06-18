class Submission < ActiveRecord::Base
  
  has_many :tasks, :order => :rank, :dependent => :destroy
  serialize :input_files
  serialize :process_definition

  accepts_nested_attributes_for :tasks
  
  before_save :remove_dups_from_input_files
  
  validates_presence_of :input_files, :message => " - You must choose at least one input file!"
  
  
  def remove_dups_from_input_files
    
    input_files.uniq! unless input_files.blank?
    
  end
  
  
  ###############################################
  #
  #  fetches the ruote process associated with this submissions wfid
  #  returns the latest error from that  process, or nil
  #

  def active?
    
    return false if self.fei_wfid.nil?
    
    process = nil
    
    p_array = RuoteKit.engine.processes
    
    p_array.each do |p|
      #find the process 
      process = p if p.wfid.eql?(self.fei_wfid)
      
      
    end
    
    if process.nil? 
      return false
    else
      return true
    end
        
  end
  
  
  
  
  ######################################################
  #
  #  submits the submissions process definition to ruote and saves the wfid in submission
  #
  
  def submit_job

    pdef = generate_process_definition
    self.process_definition = pdef
    
    save
    
    # RuoteAMQP::WorkitemListener.new(RuoteKit.engine)
    wfid = RuoteKit.engine.launch(self.process_definition)
    # Ruote.engine.wait_for(wfid)

    self.fei_wfid = wfid

    save
    
  end
  
  #######################################
  #
  #  generates a ruote process definition based on submission and its tasks
  #
  
  
  def generate_process_definition
    
    # need to reassign vars because self gets overwritten in Dsl
    
    in_files = self.input_files
    
    task_array = self.tasks
    out_project_id = self.project_id
    current_user_id = self.user_id
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
            
              request_nodes :num_nodes => "${f:previous_output_files_size}", :task_id => "#{t.id}", :role_id => "#{t.role_id}"
            
              concurrent_iterator :merge_type => 'isolate', :on_val => "${f:previous_output_files_joined}", :to_var => 'v' do

                qips_node :command => '/worker/start_work', :input_files => '${v:v}', :params_file => "#{t.params_url}",
                :executable => "#{t.executable}", :exec_timeout => "#{t.protocol.process_timeout}", :pass_filenames => "#{t.protocol.pass_filenames}", 
                :aux_files => "#{t.aux_files.join(',') unless t.aux_files.nil?}", :args => "#{t.args}", :queue => "#{t.protocol.queue}", 
                :output_project_id => "#{out_project_id}", :user_id => "#{current_user_id}"

              end
    
              merge_outputs :task_id => "#{t.id}"

            
          else
            
            wait_for :time => PROCESS_WAIT_TIME unless count == 0

            request_nodes :num_nodes => "1", :role_id => "#{t.role_id}"

            qips_node :command => '/worker/start_work', :input_files => "${f:previous_output_files_joined}", :params_file => "#{t.params_url}",
            :executable => "#{t.executable}", :exec_timeout => "#{t.protocol.process_timeout}", :pass_filenames => "#{t.protocol.pass_filenames}", 
            :aux_files => "#{t.aux_files.join(',') unless t.aux_files.nil?}", :args => "#{t.args}", :queue => "#{t.protocol.queue}", 
            :output_project_id => "#{out_project_id}", :user_id => "#{current_user_id}"
            

            rename_outputs :task_id => "#{t.id}", :task_id => "#{t.id}"
            
          end
          
        count += 1
        end
        
        console
  
      end
  
          
    end
    
    return pdef
    
    
  end
  
  
  
end
