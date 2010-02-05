class Submission < ActiveRecord::Base
  
  has_many :tasks, :order => :rank
  serialize :input_files
  
  def task_attributes=(task_attributes)
    task_attributes.each do |attributes|
      tasks.build(attributes)
    end
  end
  
  def input_file_list=(list)
    list.each do |path|
      input_files << path
    end
  end
  
  
  
end
