class AddRoleIdToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :role_id, :integer
  end

  def self.down
    remove_column :tasks, :role_id
  end
end
