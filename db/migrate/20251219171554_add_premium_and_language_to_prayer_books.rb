class AddPremiumAndLanguageToPrayerBooks < ActiveRecord::Migration[8.1]
  def change
    add_column :prayer_books, :premium_required, :boolean, default: false, null: false
    add_column :prayer_books, :language, :string, default: "pt-BR", null: false

    # Add indexes for performance
    add_index :prayer_books, :premium_required
    add_index :prayer_books, :language
    add_index :prayer_books, [ :language, :code ]
    add_index :prayer_books, [ :premium_required, :is_recommended ]

    reversible do |dir|
      dir.up do
        # Mark LOC 2019 and LOC 1662 as premium
        execute <<-SQL
          UPDATE prayer_books
          SET premium_required = true
          WHERE code IN ('loc_2019', 'loc_1662');
        SQL

        # Set language for all existing prayer books (all are pt-BR)
        execute <<-SQL
          UPDATE prayer_books
          SET language = 'pt-BR';
        SQL
      end
    end
  end
end
