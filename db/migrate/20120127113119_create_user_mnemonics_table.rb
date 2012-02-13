class CreateUserMnemonicsTable < ActiveRecord::Migration
  def change
    create_table :usermnemonics do |t|
      t.integer :mnemonic_id
      t.integer :user_id

      t.datetime :created_at

      t.timestamps
    end
  end
end
