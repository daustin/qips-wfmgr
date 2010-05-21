class RemoveOwnerFromSubmission < ActiveRecord::Migration
  def self.up
    remove_column :submissions, :owner
  end

  def self.down
    add_column :submissions, :owner, :string
  end
end
