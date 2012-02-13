class CreateListizations < ActiveRecord::Migration
  def change
    create_table :listizations do |t|
      t.integer :target_id
      t.integer :list_id
      t.integer :position
      t.datetime :created_at

      t.timestamps
    end
  end
end
