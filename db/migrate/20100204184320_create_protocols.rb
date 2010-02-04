class CreateProtocols < ActiveRecord::Migration
  def self.up
    create_table :protocols do |t|
      t.string :name
      t.text :params_template
      t.string :params_filename
      t.boolean :run_concurrent

      t.timestamps
    end
  end

  def self.down
    drop_table :protocols
  end
end
