class AddSubmissionTagToSubmission < ActiveRecord::Migration
  def self.up
    add_column :submissions, :submission_tag, :string
  end

  def self.down
    remove_column :submissions, :submission_tag
  end
end
