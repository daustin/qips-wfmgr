class AddPrettyInputListToSubmission < ActiveRecord::Migration
  def self.up
    add_column :submissions, :pretty_input_list, :text
  end

  def self.down
    remove_column :submissions, :pretty_input_list
  end
end
