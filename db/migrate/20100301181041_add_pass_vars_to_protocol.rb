class AddPassVarsToProtocol < ActiveRecord::Migration
  def self.up
    add_column :protocols, :pass_vars, :boolean, :default => false
  end

  def self.down
    remove_column :protocols, :pass_vars
  end
end
