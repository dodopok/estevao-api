class CreateLiturgicalSeasons < ActiveRecord::Migration[8.1]
  def change
    create_table :liturgical_seasons do |t|
      t.string :name
      t.string :color
      t.text :description

      t.timestamps
    end
  end
end
