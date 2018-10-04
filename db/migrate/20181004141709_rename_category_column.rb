class RenameCategoryColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :categories, :fixed, :spent
  end
end
