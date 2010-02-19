class AddDescriptionToProtocol < ActiveRecord::Migration
  def self.up
    add_column :protocols, :description, :text
  end

  def self.down
    remove_column :protocols, :description
  end
end
