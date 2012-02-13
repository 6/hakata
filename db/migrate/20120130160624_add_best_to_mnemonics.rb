class AddBestToMnemonics < ActiveRecord::Migration
  def self.up
    add_column :mnemonics, :best, :boolean
  end

  def self.down
    remove_column :mnemonics, :best
  end
end
