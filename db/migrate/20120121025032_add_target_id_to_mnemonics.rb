class AddTargetIdToMnemonics < ActiveRecord::Migration
  def self.up
    add_column :mnemonics, :target_id, :integer
  end
  
  def self.down
    remove_column :mnemonics, :target_id
  end
end
