class User < ActiveResource::Base
  self.site = ILIMS_SITE

  def workflows
    
    Workflow.find(:all, :conditions => {:user_id => self.id})
    
  end
  
  
  def subimssions
    
    Submission.find(:all, :conditions => {:user_id => self.id})
    
  end

  def items
    
    # GET /users/1/items.xml
    res = connection.get("#{self.class.prefix}#{self.class.collection_name}/#{self.id}/items")
    
  end
  
  def projects
    
    # GET /users/1/projects.xml
    res = connection.get("#{self.class.prefix}#{self.class.collection_name}/#{self.id}/projects")
    
  end


  def build_items_list
    
    @items_list = Array.new
    
    #lets build the options hash for items
    
    projects.each do |p|
    
      project = Project.find(p['id'])
    
      project.items.each do |i|
        
        
        @items_list << ["#{p['name']} --> #{i['attachment_file_name']}","#{i['id']}"]
        
      end
    end
    
    @items_list
    
  end
  
end