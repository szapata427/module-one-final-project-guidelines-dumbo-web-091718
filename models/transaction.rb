class BudgetTransaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

def self.create_transaction
  puts "Did you spend money or did you get paid? \nSelect a number. 
  1. Spent \n  2. Received"

  user_response = gets.chomp.to_i

  puts "Input the amount:"

  transaction_amount = gets.chomp.to_f

  if user_response == 1 
    transaction_amount = 0-transaction_amount
  end


  puts "Name of the transaction:"

  transaction_name = gets.chomp

  puts "Select the category for this transaction:"
    Category.all.each do |category|
      puts "#{category.id}. #{category.name}"
      
    end
    transaction_category = gets.chomp.to_i

  BudgetTransaction.new(description: transaction_name, amount: transaction_amount, category_id: transaction_category, date: Time.now)

end


end
