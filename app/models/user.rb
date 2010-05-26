class User < ActiveResource::Base
  self.site = ILIMS_SITE

  def workflows
    
    Workflow.find(:all, :conditions => {:user_id => self.id})
    
  end
  
  
  def subimssions
    
    Submission.find(:all, :conditions => {:user_id => self.id})
    
  end

  def build_items_list
    
    @items_list = Array.new
    
    #lets build the options hash for items
    
    projects = Project.get(:login_bypass, :method => 'find_projects_by_user_id', :user_id => self.id)
    projects.each do |p|
    
      project_attachments = Project.get(:login_bypass, :method => 'find_project_attachments_by_project_id', :project_id => p['id'])

      project_attachments.each do |pa|
        i = Item.get(:login_bypass, :method => 'find_item_by_id', :id => pa['item_id'] )
        @items_list << ["#{p['name']} --> #{i['attachment_file_name']}","#{pa['id']}"]
        
      end
    end
    
    @items_list
    
  end
  
end