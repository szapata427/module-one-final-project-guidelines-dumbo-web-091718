# require 'colorize'
class BudgetTransaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

def self.create_transaction(user)
  user_response = nil
  transaction_amount = ""
  transaction_category = nil 
  loop do 
    puts "\nDid you spend money or did you get paid? \nSelect a number. \n 1. Spent \n 2. Received"
    user_response = Integer(gets) rescue nil
    break if user_response == 1 || user_response == 2
    puts "\nPlease input a valid number (1 or 2)."
  end

  loop do 
    puts "\nInput the amount:"
    #transaction amount tells us the amount 
    transaction_amount = Float(gets) rescue nil
    break if transaction_amount != nil 
    puts "\nPlease input a valid amount."
  end
  #user response tells us whether amount was received or spent 
  if user_response == 1 
    transaction_amount = 0-transaction_amount
  end

  puts "\nName of the transaction:"

  transaction_name = gets.chomp

  loop do 
  puts "\nSelect the category number for this transaction:"
  #lists all the categories by category id
    Category.all.each do |category|
      puts "#{category.id}. #{category.name}"
    end
  #collects user input and compares it with category ids in our database, loops if choice is invalid
    transaction_category = Integer(gets) rescue nil
    selected_category = Category.find_by id: (transaction_category)
    break if selected_category != nil 
    puts "Please input a valid number."
    end


  BudgetTransaction.create(description: transaction_name, amount: transaction_amount, user_id: user.id, category_id: transaction_category, date: Time.now)

end


end

def view_transactions(user)
 transactions_array = BudgetTransaction.where(:user_id => user.id)
 if transactions_array == [] 
    puts "\nYou have no transactions! Create one to get started. :)"
 else
    puts "Your past transactions are:"
    transactions_array.each_with_index do |transaction, index|
      # if transaction.amount < 0
      puts "#{index+1}. Amount: #{transaction.amount}, Desc: #{transaction.description}, Date: #{transaction.date}."
      # else 
        # puts "#{index+1}. Amount: #{transaction.amount}, Desc: #{transaction.description}, Date: #{transaction.date}."
      # end
    end
 end
end


