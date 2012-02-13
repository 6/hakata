class AddNameToTarget < ActiveRecord::Migration
  def self.up
    add_column :targets, :name, :string
  end
  
  def self.down
    remove_column :targets, :name
  end
end
