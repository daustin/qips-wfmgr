class Protocol < ActiveRecord::Base
  has_many :workflows, :through => :stages
  has_many :parameters, :order => 'position'
  has_many :tasks
  
  serialize :default_aux_files
  
  accepts_nested_attributes_for :parameters, :reject_if => lambda { |a| a[:var_name].blank? } , :allow_destroy => true
    
  def role
    
    @role ||= Role.find(role_id) unless role_id.blank?
    
  end
  
  def build_selected_items_list
    
    @items_list = Array.new
    
    default_aux_files.each do |daf|
      
      pa = Project.get(:login_bypass, :method => 'find_project_attachment_by_id', :id => daf)
      p = Project.get(:login_bypass, :method => 'find_project_by_id', :id => pa['project_id'])
      i = Item.get(:login_bypass, :method => 'find_item_by_id', :id => pa['item_id'])
      @items_list << ["#{p['name']} --> #{i['attachment_file_name']}","#{pa['id']}"]
            
    end
    
    
  end
  
  
  
  
end
