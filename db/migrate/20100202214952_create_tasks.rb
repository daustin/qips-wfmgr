class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.text :process_def
      t.integer :rank
      t.integer :submission_id
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
