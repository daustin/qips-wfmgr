class RemoveExecErrorFromTask < ActiveRecord::Migration
  def self.up
    remove_column :tasks, :exec_error
  end

  def self.down
    add_column :tasks, :exec_error, :text
  end
end
