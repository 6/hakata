class AddIdToFields < ActiveRecord::Migration
  def self.up
    add_column :targets, :field_id, :integer
  end
  
  def self.down
    remove_column :targets, :field_id
  end
end
