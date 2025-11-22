class CreatePsalms < ActiveRecord::Migration[8.1]
  def change
    create_table :psalms do |t|
      t.integer :number, null: false
      t.string :title
      t.jsonb :verses, default: {}, null: false
      t.string :translation, default: 'loc_2015'
      t.text :antiphon

      t.timestamps
    end
    add_index :psalms, :number
    add_index :psalms, [ :number, :translation ], unique: true
  end
end
