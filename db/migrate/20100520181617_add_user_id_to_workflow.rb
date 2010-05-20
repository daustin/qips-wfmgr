class AddUserIdToWorkflow < ActiveRecord::Migration
  def self.up
    add_column :workflows, :user_id, :integer
  end

  def self.down
    remove_column :workflows, :user_id
  end
end
