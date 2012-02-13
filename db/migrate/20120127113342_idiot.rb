class Idiot < ActiveRecord::Migration
  def up
    drop_table :usermnemonics
  end
end
