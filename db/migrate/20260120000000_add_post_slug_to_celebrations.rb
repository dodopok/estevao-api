class AddPostSlugToCelebrations < ActiveRecord::Migration[8.0]
  def change
    add_column :celebrations, :post_slug, :string
    add_index :celebrations, :post_slug
  end
end
