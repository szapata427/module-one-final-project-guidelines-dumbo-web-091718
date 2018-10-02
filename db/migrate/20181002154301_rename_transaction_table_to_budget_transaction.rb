class RenameTransactionTableToBudgetTransaction < ActiveRecord::Migration[5.0]
  def change
    rename_table("transactions", "budget_transactions")
  end
end
