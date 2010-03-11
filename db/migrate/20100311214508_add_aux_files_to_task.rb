class AddAuxFilesToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :aux_files, :text
  end

  def self.down
    remove_column :tasks, :aux_files
  end
end
