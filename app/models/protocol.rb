class Protocol < ActiveRecord::Base
  has_many :workflows, :through => :stages
  has_many :parameters, :order => 'position'
  has_many :tasks
  
  serialize :default_aux_files
  
  accepts_nested_attributes_for :parameters, :reject_if => lambda { |a| a[:var_name].blank? } , :allow_destroy => true
    
  
end
