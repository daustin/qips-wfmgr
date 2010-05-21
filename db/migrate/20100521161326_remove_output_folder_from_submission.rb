class RemoveOutputFolderFromSubmission < ActiveRecord::Migration
  def self.up
    remove_column :submissions, :output_folder
  end

  def self.down
    add_column :submissions, :output_folder, :string
  end
end
