class AddParamValuesParamsUrlParamsContentsToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :param_values, :text
    add_column :tasks, :params_url, :string
    add_column :tasks, :params_contents, :text
  end

  def self.down
    remove_column :tasks, :params_contents
    remove_column :tasks, :params_url
    remove_column :tasks, :param_values
  end
end
