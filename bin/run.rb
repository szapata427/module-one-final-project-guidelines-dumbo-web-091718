require_relative '../config/environment'

require 'pry'


# shows us if the user has an account with Every Cent.
puts "Welcome to Every Cent! Do you have an account with us?".colorize(:cyan)
puts "1.Yes \n2.No".colorize(:light_green)
account_active = gets.chomp.downcase
while account_active != "yes" && account_active != "no" && account_active != "1" && account_active != "2" 
  puts "\nInvalid response, please try again".colorize(:red)
  account_active = gets.chomp.downcase 
end

current_user = ""
# creates an account if the user does not have one. 
if account_active == "no" || account_active == "2"
  current_user = User.create_new_user
  puts "Thank you for creating an account with us!".colorize(:cyan)
elsif account_active == "yes" || account_active == "1"
  current_user = User.user_login 
end

  # creates fixed categories. 
  # create_category


  loop do 
    #main menu = transactions, check balance, your goals and exit the program. 
    # it is a loop. 

  puts "\nWhat would you like to do today? Select a number :)".colorize(:cyan)
  puts " 1. Transactions \n 2. Check Spending Information \n 3. Your Goals \n 4. Exit".colorize(:light_green)

  user_choice = gets.chomp.to_i

    case user_choice  
      when 1 
        loop do
          puts "\nWould you like to \n 1. Create a transaction \n 2. View your transactions \n 3. Exit".colorize(:blue)
          user_transaction_response = Integer(gets) rescue nil 
            # Creates, views, and cancels a transaction. It also adjusts the balance.
          if user_transaction_response == 1
            new_transaction = BudgetTransaction.create_transaction(current_user)
            current_user.update_attribute(:balance, current_user.balance += new_transaction.amount)  
            puts "Your new balance is $#{'%.2f' % current_user.balance}!"

          elsif user_transaction_response == 2
            view_transactions(current_user)
          elsif user_transaction_response == 3
            break
          else 
            puts "\nNot a valid input. Please input a number (1-3).".colorize(:red)
          end
        end
      when 2

        user_spending_response = ""

        loop do 
          puts "\nWould you like to \n 1. View Balance \n 2. View Spending by Category. \n 3. Exit".colorize(:blue)
          user_spending_response = Integer(gets) rescue nil 
          

          if user_spending_response == 1
            puts "\nYour current balance is $#{'%.2f' % current_user.balance}!".colorize(:yellow)
          elsif user_spending_response == 2
            category_spending_amount(current_user)
          elsif user_spending_response ==3 
            break
          else 
            puts "\nNot a valid input. Please input a number (1-3).".colorize(:red)
          end
        end

      when 3 
        puts "\nSet spending goals to help you reach financial success!".colorize(:cyan)
        loop do
          puts "\nWould you like to \n 1. Create a goal  \n 2. View your current goals \n 3. View goal progress \n 4. Delete a goal \n 5. Exit".colorize(:light_green)
          user_goal_response = gets.chomp.to_i
          # Allows you to create a goal, view current goals, view goal progress, and exit to main menu. 
          if user_goal_response == 1 
            create_goal(current_user)

          elsif user_goal_response == 2 
            view_goal(current_user)

          elsif user_goal_response ==3
              goal_amount_progress = current_user.balance - total_goal_amount(current_user)
              # shows the user goal amount progress (balance - users total goal amount)
                if goal_amount_progress < 0
                puts "You spent more than what you were allowed to! You are $#{'%.2f' % (0 - goal_amount_progress)} over your spending goal!".colorize(:light_red)
                elsif goal_amount_progress == 0
                    puts "You can't spend anymore if you want to stay within your goals! You are at $0.00 in avaliable spending.".colorize(:yellow)
                else
                  puts "You can spend $#{'%.2f' % goal_amount_progress} and still be within your saving goals. WOW!".colorize(:green)
                end
          elsif user_goal_response == 4
              delete_goal(current_user)
          elsif user_goal_response == 5
            break

          else 
            puts "\nNot a valid input. Please input a number (1-5).".colorize(:red)
          end
        end 
      when 4
        break
      else 
        puts "\nNot a valid input. Please input a number (1-4).".colorize(:red)
    end
 
  end 



  puts "Goodbye #{current_user.name}! Hope you saved $$$$ Hoe ;)".colorize(:color => :light_cyan, :background => :light_green)

