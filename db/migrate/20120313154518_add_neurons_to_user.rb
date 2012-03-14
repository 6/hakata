class AddNeuronsToUser < ActiveRecord::Migration
  def up
    add_column :users, :neurons, :integer
  end

  def down
    remove_column :users, :neurons
  end
end
