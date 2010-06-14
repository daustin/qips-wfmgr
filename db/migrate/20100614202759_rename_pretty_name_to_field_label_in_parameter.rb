class RenamePrettyNameToFieldLabelInParameter < ActiveRecord::Migration
  def self.up
    rename_column :parameters, :pretty_name, :field_label
  end

  def self.down
    rename_column :parameters, :field_label, :pretty_name
  end
end
