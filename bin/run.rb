require_relative '../config/environment'

require 'pry'



puts "Welcome to Every Cent! Do you have an account with us?"
puts "1.Yes \n2.No"
account_active = gets.chomp.downcase
while account_active != "yes" && account_active != "no"
  puts "\nInvalid response, please try again"
  account_active = gets.chomp.downcase 
end

current_user = ""

if account_active == "no"
  current_user = User.create_new_user
  puts "Thank you for creating an account with us!"
elsif account_active == "yes"
  current_user = User.user_login 
end


  create_category


  loop do 

  puts "\nWhat would you like to do today? Select a number :)"
  puts " 1. Transactions \n 2. Check Balance \n 3. Your Goals \n 4. Exit"

  user_choice = gets.chomp.to_i

    case user_choice  
      when 1 
        loop do
          puts "\nWould you like to \n 1. Create a transaction \n 2. View your transactions \n 3. Cancel"
          user_transaction_response = gets.chomp.to_i

          if user_transaction_response == 1
            new_transaction = BudgetTransaction.create_transaction(current_user)
            current_user.update_attribute(:balance, current_user.balance += new_transaction.amount)  
            puts "Your new balance is $#{'%.2f' % current_user.balance}!"
          elsif user_transaction_response == 2
            view_transactions(current_user)
          elsif user_transaction_response == 3
            break
          else 
            puts "Invalid response, please try again."
          end
        end
      when 2
        puts "\nYour current balance is $#{'%.2f' % current_user.balance}!"
      when 3 
        puts "\nSet spending goals to help you reach financial success!" 
        puts "Would you like to \n 1. Create a goal  \n 2. View your current goals"
        user_goal_response = gets.chomp.to_i
        user_goal_response == 1 ? create_goal(current_user) : view_goal(current_user)
      when 4

        break
    end
 
  end 



  puts "Goodbye #{current_user.name}! Hope you saved $$$$ Hoe ;)"

