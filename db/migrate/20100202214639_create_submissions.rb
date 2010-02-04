class CreateSubmissions < ActiveRecord::Migration
  def self.up
    create_table :submissions do |t|
      t.string :owner
      t.has_many :tasks

      t.timestamps
    
    end
  end

  def self.down
    drop_table :submissions
  end
end
