class RemoveLanguageFromCollectsAndLiturgicalTexts < ActiveRecord::Migration[8.1]
  def change
    remove_column :collects, :language, :string
    remove_column :liturgical_texts, :language, :string, default: "pt-BR"
  end
end
