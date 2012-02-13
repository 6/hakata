class ChangeTargetsToFacts < ActiveRecord::Migration
  def up
    rename_table(:targets, :facts)
  end

  def down
  end
end
