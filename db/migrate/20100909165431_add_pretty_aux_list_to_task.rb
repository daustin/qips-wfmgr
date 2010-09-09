class AddPrettyAuxListToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :pretty_aux_list, :text
  end

  def self.down
    remove_column :tasks, :pretty_aux_list
  end
end
