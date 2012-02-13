class AddDescriptionToFields < ActiveRecord::Migration
  def self.up
    add_column :fields, :description, :text
  end
  
  def self.down
    remove_column :fields, :description
  end
end
