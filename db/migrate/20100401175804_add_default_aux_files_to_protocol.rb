class AddDefaultAuxFilesToProtocol < ActiveRecord::Migration
  def self.up
    add_column :protocols, :default_aux_files, :text
  end

  def self.down
    remove_column :protocols, :default_aux_files
  end
end
