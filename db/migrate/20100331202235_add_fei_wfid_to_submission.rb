class AddFeiWfidToSubmission < ActiveRecord::Migration
  def self.up
    add_column :submissions, :fei_wfid, :string
  end

  def self.down
    remove_column :submissions, :fei_wfid
  end
end
