class RemoveScoreFromMnemonics < ActiveRecord::Migration
  def up
    remove_column :mnemonics, :score
  end

  def down
    add_column :mnemonics, :score
  end
end
