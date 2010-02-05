class AddWfidToSubmission < ActiveRecord::Migration
  def self.up
    add_column :submissions, :wfid, :string
  end

  def self.down
    remove_column :submissions, :wfid
  end
end
