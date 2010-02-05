class AddProtocolIdToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :protocol_id, :integer
  end

  def self.down
    remove_column :tasks, :protocol_id
  end
end
