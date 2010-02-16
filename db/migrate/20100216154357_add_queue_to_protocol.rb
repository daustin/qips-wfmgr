class AddQueueToProtocol < ActiveRecord::Migration
  def self.up
    add_column :protocols, :queue, :string, :default => 'test'
  end

  def self.down
    remove_column :protocols, :queue
  end
end
