class Task < ActiveRecord::Base
  
  belongs_to :submission
  belongs_to :protocol
  
end
