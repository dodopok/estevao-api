class AddPremiumFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :revenue_cat_user_id, :string
    add_column :users, :premium_expires_at, :datetime

    add_index :users, :revenue_cat_user_id
    add_index :users, :premium_expires_at
  end
end
