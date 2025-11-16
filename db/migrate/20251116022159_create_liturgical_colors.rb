class CreateLiturgicalColors < ActiveRecord::Migration[8.1]
  def change
    create_table :liturgical_colors do |t|
      t.string :name
      t.string :hex_code
      t.text :usage_description

      t.timestamps
    end
  end
end
