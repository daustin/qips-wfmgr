class Stage < ActiveRecord::Base
  
  belongs_to :protocol
  belongs_to :workflow
    
end
