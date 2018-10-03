require_relative '../config/environment'

require 'pry'



puts "Welcome to Every Cent! Do you have an account with us?"
puts "1.Yes \n2.No"
account_active = gets.chomp.downcase

current_user = ""

if account_active == "no"
  test_user = User.create_new_user
else
 current_user = User.user_login 
end


  create_category


  loop do 

  puts "\nWhat would you like to do today? Select a number :)"
  puts " 1. Transactions \n 2. Check Balance \n 3. Your Goals \n 4. Exit"

  user_choice = gets.chomp.to_i


    case user_choice  
    when 1 
      new_transaction = BudgetTransaction.create_transaction
      current_user.update_attribute(:balance, current_user.balance += new_transaction.amount)   
    
      puts "Your new balance is $#{current_user.balance}."
    when 2
      #checkbalance
      puts "\nYour current balance is $#{current_user.balance}."
  
    when 4
      puts "are you jason???"
      break
    end
 
  end 

  puts "Goodbye #{current_user.name}! Hope you saved $$$$ Hoe ;)"

