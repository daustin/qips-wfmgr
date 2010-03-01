class RemovePassVarsFromProtocol < ActiveRecord::Migration
  def self.up
    remove_column :protocols, :pass_vars
  end

  def self.down
    add_column :protocols, :pass_vars, :boolean
  end
end
