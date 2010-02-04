class CreateWorkflows < ActiveRecord::Migration
  def self.up
    create_table :workflows do |t|
      t.string :name
      t.text :description

      t.timestamps
      
      t.has_many :stages
      t.has_many :protocols, :through => :stages
      
    end
  end

  def self.down
    drop_table :workflows
  end
end
