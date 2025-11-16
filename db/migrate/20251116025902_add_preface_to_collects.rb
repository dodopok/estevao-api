class AddPrefaceToCollects < ActiveRecord::Migration[8.1]
  def change
    add_column :collects, :preface, :string
  end
end
