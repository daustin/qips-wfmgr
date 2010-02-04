class Workflow < ActiveRecord::Base
  has_many :stages, :order => :position
  has_many :protcols, :through => :stages
  
  
  def stage_attributes=(stage_attributes)
    #before we build these, lets destroy the existing ones
    Stage.delete(self.stages.collect {|s| s.id})
    position = 1
    stage_attributes.each do |attributes|
      attributes[:position] = position
      stages.build(attributes)
      position += 1
    end
  end
  
  
  
  
    
end
