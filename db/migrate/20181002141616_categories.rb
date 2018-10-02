class Categories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :priority
      t.boolean :fixed
    end
  end
end
