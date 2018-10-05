require_relative '../config/environment'

require 'pry'


prompt = TTY::Prompt.new
system "clear"


puts "
---------------------------------------------------------------------.
| .--                    FEDERAL RESERVE NOTE                    .-- |
| |_       ......    THE UNTIED STATES OF AMERICA                |_  |
| __)    ``````````             ______            B93810455B     __) |
|      2        ___            /      \\                     2        |
|              /|~\\\\          /  _-\\\\  \\           __ _ _ _  __      |
|             | |-< |        |  //   \\  |         |_  | | | |_       |
|              \\|_//         | |-  o o| |         |   | `.' |__      |
|               ~~~          | |\\   b.' |                            |
|       B83910455B           |  \\ '~~|  |                            |
| .--  2                      \\\\_/ ```__/    ....            2   .-- |
| |_        ///// ///// ////   \\__\\'`\\/      ``  //// / ////     |_  |
| __)                   ¢ E V E R Y ¢ C E N T ¢                  __) |
`--------------------------------------------------------------------'
".colorize(:green)



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

  user_choice = prompt.select("What would you like to do today?".colorize(:cyan), ["1. Transactions",
  "2. Check Spending Information", "3. Your Goals", "4. Exit"])

    case user_choice  
      when "1. Transactions" 
        loop do
          puts ""
          user_transaction_response = prompt.select("Would you like to".colorize(:cyan), ["1. Create a transaction", "2. View your transactions",
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
          puts ""
          user_spending_response = prompt.select("Would you like to:".colorize(:cyan), ["1. View Balance", "2. View Spending by Category", "3. Exit"])
          

          if user_spending_response == "1. View Balance"
            puts "\nYour current balance is $#{'%.2f' % current_user.balance}!".colorize(:yellow)
          elsif user_spending_response == "2. View Spending by Category"
            category_spending_amount(current_user)
          elsif user_spending_response == "3. Exit"
            break
          end
        end

      when "3. Your Goals" 
        puts "\nSet spending goals to help you reach financial success!".colorize(:cyan)
        loop do
          puts ""
          user_goal_response = prompt.select("Would you like to:".colorize(:cyan), ["1. Create a goal", "2. View your current goals", "3. View goal progress", "4. Delete a goal", "5. Exit"])
          # Allows you to create a goal, view current goals, view goal progress, and exit to main menu. 
          if user_goal_response == "1. Create a goal" 
            create_goal(current_user)

          elsif user_goal_response == "2. View your current goals" 
            view_goal(current_user)

          elsif user_goal_response == "3. View goal progress"
              goal_amount_progress = current_user.balance - total_goal_amount(current_user)
              # shows the user goal amount progress (balance - users total goal amount)
                if goal_amount_progress < 0
                puts "You spent more than what you were allowed to! You are $#{'%.2f' % (0 - goal_amount_progress)} over your spending goal!".colorize(:light_red)
                elsif goal_amount_progress == 0
                    puts "You can't spend anymore if you want to stay within your goals! You are at $0.00 in avaliable spending.".colorize(:yellow)
                else
                  puts "You can spend $#{'%.2f' % goal_amount_progress} and still be within your saving goals. WOW!".colorize(:green)
                end
          elsif user_goal_response == "4. Delete a goal"
              delete_goal(current_user)
          elsif user_goal_response == "5. Exit"
            break
          end
        end
         
      when "4. Exit"
        break
    end
 
  end 



  puts "\nGoodbye #{current_user.name}! Hope you saved 💸 💸 💸  😉.".colorize(:green)

