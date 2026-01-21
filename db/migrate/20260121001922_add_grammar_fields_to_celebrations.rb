class AddGrammarFieldsToCelebrations < ActiveRecord::Migration[8.1]
  def change
    add_column :celebrations, :person_type, :integer, default: 0, null: false
    add_column :celebrations, :gender, :integer, default: 0, null: false

    add_index :celebrations, :person_type
    add_index :celebrations, :gender
  end
end
