class AddExecutableArgsToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :executable, :string
    add_column :tasks, :args, :string
  end

  def self.down
    remove_column :tasks, :args
    remove_column :tasks, :executable
  end
end
