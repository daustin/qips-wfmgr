class AddInputFilesOutputFolderToSubmission < ActiveRecord::Migration
  def self.up
    add_column :submissions, :input_files, :string
    add_column :submissions, :output_folder, :string
  end

  def self.down
    remove_column :submissions, :output_folder
    remove_column :submissions, :input_files
  end
end
