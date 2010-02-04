class RemoveArgsFromProtocol < ActiveRecord::Migration
  def self.up
    remove_column :protocols, :args
  end

  def self.down
    add_column :protocols, :args, :string
  end
end
