class CreateParameters < ActiveRecord::Migration
  def self.up
    create_table :parameters do |t|
      t.string :pretty_name
      t.string :var_name
      t.text :description
      t.string :field_type
      t.string :initial_value
      t.text :value_hash
      t.string :remote_value
      t.belongs_to :protocol
      t.timestamps
      
    end
  end

  def self.down
    drop_table :parameters
  end
end
