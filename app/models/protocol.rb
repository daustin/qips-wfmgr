class Protocol < ActiveRecord::Base
  has_many :workflows, :through => :stages
  
end
