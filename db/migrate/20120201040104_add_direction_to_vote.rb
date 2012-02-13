class AddDirectionToVote < ActiveRecord::Migration
  def self.up
    add_column :votes, :up, :boolean
  end

  def self.down
    remove_column :votes, :up
  end
end

