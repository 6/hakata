class AddUserToMnemonics < ActiveRecord::Migration
  def self.up
    add_column :mnemonics, :user_id, :integer
  end
  
  def self.down
    remove_column :mnemonics, :user_id
  end
end
