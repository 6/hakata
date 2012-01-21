class AddTargetIdToElements < ActiveRecord::Migration
  def self.up
    add_column :elements, :target_id, :integer
  end
  
  def self.down
    remove_column :elements, :target_id
  end
end