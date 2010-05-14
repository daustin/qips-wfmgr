class AddRoleIdToProtocol < ActiveRecord::Migration
  def self.up
    add_column :protocols, :role_id, :integer
  end

  def self.down
    remove_column :protocols, :role_id
  end
end
