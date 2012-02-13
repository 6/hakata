class ChangeAllTargetIdColumnsToFactId < ActiveRecord::Migration
  def up
    rename_column(:elements, :target_id, :fact_id)
    rename_column(:listizations, :target_id, :fact_id)
    rename_column(:mnemonics, :target_id, :fact_id)
  end

  def down
  end
end
