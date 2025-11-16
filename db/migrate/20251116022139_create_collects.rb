class CreateCollects < ActiveRecord::Migration[8.1]
  def change
    create_table :collects do |t|
      t.references :celebration, null: true, foreign_key: true
      t.string :sunday_reference
      t.references :season, null: true, foreign_key: { to_table: :liturgical_seasons }
      t.text :text
      t.string :language

      t.timestamps
    end
  end
end
