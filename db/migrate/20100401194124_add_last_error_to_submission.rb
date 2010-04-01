class AddLastErrorToSubmission < ActiveRecord::Migration
  def self.up
    add_column :submissions, :last_error, :text, :default => ''
  end

  def self.down
    remove_column :submissions, :last_error
  end
end
