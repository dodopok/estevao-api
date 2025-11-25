class AddTitleToLiturgicalTexts < ActiveRecord::Migration[8.1]
  def change
    add_column :liturgical_texts, :title, :string
  end
end
