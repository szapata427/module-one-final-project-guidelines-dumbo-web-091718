require_relative '../config/environment'

require 'pry'


prompt = TTY::Prompt.new
system "clear"


account_active = prompt.select("Welcome to Every Cent! Do you have an account with us?".colorize(:cyan), ["Yes", "No"])


current_user = ""
# creates an account if the user does not have one. 
if account_active == "No" 
  current_user = User.create_new_user
  puts "Thank you for creating an account with us!".colorize(:cyan)
elsif account_active == "Yes" 
  current_user = User.user_login 
end
# system "clear"

  loop do 
    #main menu = transactions, check balance, your goals and exit the program. 
    # it is a loop. 

  puts ""

  user_choice = prompt.select("What would you like to do today? Select a number :)".colorize(:cyan), ["1. Transactions",
  "2. Check Spending Information", "3. Your Goals", "4. Exit"])

    case user_choice  
      when "1. Transactions" 
        loop do
          puts ""
          user_transaction_response = prompt.select("Would you like to".colorize(:blue), ["1. Create a transaction", "2. View your transactions",
        "3. Exit"])
            # Creates, views, and cancels a transaction. It also adjusts the balance.
          if user_transaction_response == "1. Create a transaction"
            new_transaction = BudgetTransaction.create_transaction(current_user)
            current_user.update_attribute(:balance, current_user.balance += new_transaction.amount)  
            puts "\nYour new balance is $#{'%.2f' % current_user.balance}!"

          elsif user_transaction_response == "2. View your transactions"
            view_transactions(current_user)
          elsif user_transaction_response == "3. Exit"
            break
          end
        end
      when "2. Check Spending Information"

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

      when "3. Your Goals" 
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
      when "4. Exit"
        break
    end
 
  end 



  puts "Goodbye #{current_user.name}! Hope you saved $$$$ Hoe ;)".colorize(:color => :light_cyan, :background => :light_green)

