class AddScoreToMnemonics < ActiveRecord::Migration
  def self.up
    add_column :mnemonics, :score, :integer
  end
  
  def self.down
    remove_column :mnemonics, :score
  end
end
