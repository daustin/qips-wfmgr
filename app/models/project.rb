class Project < ActiveResource::Base
  self.site = ILIMS_SITE

  def items
    
    @items = Item.get(:index_all, :project_id => self.id )
    
  end
  
  
end