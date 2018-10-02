class Transactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :description
      t.float :amount
      t.integer :user_id
      t.integer :category_id
      t.datetime :date

    end
  end
end
