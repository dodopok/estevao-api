class AddPaginationIndexesToLifeRules < ActiveRecord::Migration[8.1]
  def change
    # Composite index for public_rules scope
    add_index :life_rules, [ :is_public, :approved ],
              name: 'index_life_rules_on_public_approved',
              where: 'is_public = true AND approved = true'

    # Index for search by title (case-insensitive)
    add_index :life_rules, 'LOWER(title)', name: 'index_life_rules_on_lower_title'

    # Note: adoption_count index already exists, skipping
  end
end
