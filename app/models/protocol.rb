class Protocol < ActiveRecord::Base
  has_many :workflows, :through => :stages
  has_many :parameters
  
  
  def parameter_attributes=(parameter_attributes)
    Parameter.delete(self.parameters.collect {|iof| iof.id})
    parameter_attributes.each do |attributes|
      parameters.build(attributes)
    end
  end
  
  
end
