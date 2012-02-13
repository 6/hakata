class AddTypeAndValueToElements < ActiveRecord::Migration
  def self.up
    add_column :elements, :type, :string
    add_column :elements, :value, :string
  end
  
  def self.down
    remove_column :elements, :type
    remove_column :elements, :value
  end
end
