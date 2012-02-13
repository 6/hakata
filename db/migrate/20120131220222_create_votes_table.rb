class CreateVotesTable < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.text :body
      t.integer :user_id
      t.integer :mnemonic_id

      t.timestamps
    end
  end
end
