class RenameValueHashRemoteValueInParameter < ActiveRecord::Migration
  def self.up
    rename_column :parameters, :value_hash, :value_options
    rename_column :parameters, :remote_value, :remote_value_options
  end

  def self.down
    rename_column :parameters, :value_options, :value_hash
    rename_column :parameters, :remote_value_options, :remote_value
  end
end
