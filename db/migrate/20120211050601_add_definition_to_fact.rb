class AddDefinitionToFact < ActiveRecord::Migration
  def change
    add_column(:facts, :definition, :text)
  end
end
