class CreateListsTargetsTable < ActiveRecord::Migration
  def self.up
    create_table 'lists_targets', :id => false do |t|
      t.column :list_id, :integer
      t.column :target_id, :integer
    end
  end
  
  def self.down
    drop_table 'lists_targets'
  end
end
