# require 'colorize'
class BudgetTransaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

def self.create_transaction(user)
  prompt = TTY::Prompt.new
  user_response = nil
  transaction_amount = ""
  transaction_category = nil 

    puts "" 
    user_response = prompt.select("Did you spend money or did you get paid?".colorize(:cyan), ["1. Spent", "2. Received"]) 

  loop do 
    puts "\nInput the amount:"
    #transaction amount tells us the amount 
    transaction_amount = Float(gets) rescue 0
    break if transaction_amount > 0
    puts "\nPlease input a valid amount.".colorize(:red)
  end
  #user response tells us whether amount was received or spent 
  if user_response == "1. Spent" 
    transaction_amount = 0-transaction_amount
  end

  puts "\nName of the transaction:".colorize(:blue)

  transaction_name = gets.chomp

  spent_category_array = Category.all.map do |category| 
                            if category.spent == true 
                              category.name 
                             end 
                             end.compact 
  received_category_array = Category.all.map do |category| 
                              if category.spent == false 
                                category.name  
                              end
                              end.compact 
  category_name = ""                            
  if user_response == "1. Spent"
      puts ""
      category_name = prompt.select("Select the category number for this transaction:", spent_category_array)
      
  elsif user_response == "2. Received"
      puts ""
      category_name = prompt.select("Select the category number for this transaction:", received_category_array)
  end
    transaction_category = Category.find_by name: category_name 


  BudgetTransaction.create(description: transaction_name, amount: transaction_amount, user_id: user.id, category_id: transaction_category.id, date: Time.now)

end


end

def view_transactions(user)
 transactions_array = BudgetTransaction.where(:user_id => user.id)
 if transactions_array == [] 
    puts "\nYou have no transactions! Create one to get started. :)".colorize(:blue)
 else
    puts "Your past transactions are:".colorize(:blue)
    transactions_array.each_with_index do |transaction, index|
      if transaction.amount < 0
      puts "#{index+1}. Amount: -$#{'%.2f' % (0-transaction.amount)}, Desc: #{transaction.description}, Date: #{transaction.date}.".colorize(:red)
      else 
        puts "#{index+1}. Amount: $#{'%.2f' % transaction.amount}, Desc: #{transaction.description}, Date: #{transaction.date}.".colorize(:green)
      end
    end
 end
end


