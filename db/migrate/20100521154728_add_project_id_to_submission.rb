class AddProjectIdToSubmission < ActiveRecord::Migration
  def self.up
    add_column :submissions, :project_id, :integer
  end

  def self.down
    remove_column :submissions, :project_id
  end
end
