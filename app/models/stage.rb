class Stage < ActiveRecord::Base
  
  belongs_to :protocol
  belongs_to :workflow
  
  after_save :set_position
  
  def set_position
    
    if self.position.blank? || self.position == 0
      
      self.position = self.id 
      save
    end
    
  end
    
end
