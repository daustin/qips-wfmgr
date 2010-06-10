class Protocol < ActiveRecord::Base
  has_many :workflows, :through => :stages
  has_many :parameters, :order => 'position'
  has_many :tasks
  
  serialize :default_aux_files
  
  accepts_nested_attributes_for :parameters, :reject_if => lambda { |a| a[:var_name].blank? } , :allow_destroy => true
  
  before_save :remove_dups_from_default_aux_files
    
  def role
    
    @role ||= Role.find(role_id) unless role_id.blank?
    
  end
  
  def build_selected_items_list
    
    @items_list = Array.new
    aux_files = self.default_aux_files ||= Array.new
    aux_files.each do |daf|
      
      i = Item.find(daf)
      @items_list << ["#{i.attachment_file_name}","#{i.id}"]
            
    end
    
    return @items_list
    
  end
  
  
  def remove_dups_from_default_aux_files
    
    if self.default_aux_files.blank?
      self.default_aux_files = Array.new
    else
      self.default_aux_files = self.default_aux_files.uniq
    end
    
  end
  
  
  
end
