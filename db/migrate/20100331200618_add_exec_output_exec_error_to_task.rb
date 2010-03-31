class AddExecOutputExecErrorToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :exec_output, :text
    add_column :tasks, :exec_error, :text
  end

  def self.down
    remove_column :tasks, :exec_error
    remove_column :tasks, :exec_output
  end
end
