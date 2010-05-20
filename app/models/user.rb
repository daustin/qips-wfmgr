class User < ActiveResource::Base
  self.site = ILIMS_SITE

  def workflows
    
    Workflow.find(:all, :conditions => {:user_id => self.id})
    
  end
  
  
  def subimssions
    
    Submission.find(:all, :conditions => {:user_id => self.id})
    
  end


  
end