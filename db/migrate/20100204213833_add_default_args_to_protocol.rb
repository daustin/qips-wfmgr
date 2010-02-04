class AddDefaultArgsToProtocol < ActiveRecord::Migration
  def self.up
    add_column :protocols, :default_args, :string
  end

  def self.down
    remove_column :protocols, :default_args
  end
end
