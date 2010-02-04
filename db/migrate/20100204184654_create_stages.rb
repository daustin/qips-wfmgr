class CreateStages < ActiveRecord::Migration
  def self.up
    create_table :stages do |t|
      t.integer :position

      t.timestamps
      
      t.belongs_to :workflow
      t.belongs_to :protocol
      
    end
  end

  def self.down
    drop_table :stages
  end
end
