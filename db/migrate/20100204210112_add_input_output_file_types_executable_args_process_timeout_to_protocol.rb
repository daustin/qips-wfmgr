class AddInputOutputFileTypesExecutableArgsProcessTimeoutToProtocol < ActiveRecord::Migration
  def self.up
    add_column :protocols, :input_file_types, :string
    add_column :protocols, :output_file_types, :string
    add_column :protocols, :executable, :string
    add_column :protocols, :args, :string
    add_column :protocols, :process_timeout, :integer
  end

  def self.down
    remove_column :protocols, :process_timeout
    remove_column :protocols, :args
    remove_column :protocols, :executable
    remove_column :protocols, :output_file_types
    remove_column :protocols, :input_file_types
  end
end
