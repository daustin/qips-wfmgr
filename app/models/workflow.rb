class Workflow < ActiveRecord::Base
  has_many :stages, :order => :position, :dependent => :destroy
  has_many :protocols, :through => :stages
  
  accepts_nested_attributes_for :stages, :reject_if => lambda { |a| a[:protocol_id].blank? } , :allow_destroy => true
  

    
end
