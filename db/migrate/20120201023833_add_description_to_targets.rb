class AddDescriptionToTargets < ActiveRecord::Migration
  def self.up
    add_column :targets, :description, :text
  end

  def self.down
    remove_column :targets, :description
  end
end
