class CreateMnemonics < ActiveRecord::Migration
  def change
    create_table :mnemonics do |t|
      t.text :body

      t.timestamps
    end
  end
end
