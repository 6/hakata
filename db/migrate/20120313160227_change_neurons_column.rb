class ChangeNeuronsColumn < ActiveRecord::Migration
  def change
    change_column :users, :neurons, :integer, :default => 0
  end
end
