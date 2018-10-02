class Goals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.string :description
      t.float :amount
      t.integer :category_id
      t.float :difference
      t.integer :user_id
    end
  end
end
