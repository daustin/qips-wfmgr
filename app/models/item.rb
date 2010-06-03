class Item < ActiveResource::Base
  self.site = "#{ILIMS_SITE}"
  
  def projects
    
    # GET /items/1/projects.xml
    res = connection.get("#{self.class.prefix}#{self.class.collection_name}/#{self.id}/projects")
    
  end
  
  
end