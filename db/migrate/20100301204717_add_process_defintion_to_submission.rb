class AddProcessDefintionToSubmission < ActiveRecord::Migration
  def self.up
    add_column :submissions, :process_definition, :text, :default => ''
  end

  def self.down
    remove_column :submissions, :process_definition
  end
end
