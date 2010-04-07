class AddPositionToParameter < ActiveRecord::Migration
  def self.up
    add_column :parameters, :position, :integer, :default => 0
  end

  def self.down
    remove_column :parameters, :position
  end
end
