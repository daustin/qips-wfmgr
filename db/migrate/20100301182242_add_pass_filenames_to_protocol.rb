class AddPassFilenamesToProtocol < ActiveRecord::Migration
  def self.up
    add_column :protocols, :pass_filenames, :boolean
  end

  def self.down
    remove_column :protocols, :pass_filenames
  end
end
