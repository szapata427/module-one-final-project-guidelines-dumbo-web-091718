class User < ActiveRecord::Base
  has_many :budget_transaction
  has_many :goal
  has_many :category, through: :budget_transaction
  

  def self.create_new_user
    puts "\nPlease input your full name"
    user_name = gets.chomp

    puts "\nEnter your email:"
    user_email = gets.chomp

    user_password = create_password
    # create_password is a helper method to loop if passwords dont match.

    puts "\nWhat is your occupation?"
    user_occupation = gets.chomp

    puts "\nEnter your age:"
    user_age = gets.chomp

    puts "\nLast step! What is your starting budget?"
    user_balance = gets.chomp.to_f 
    puts "Awesome! Your starting budget is #{user_balance}."

    puts "\nWelcome to Every Cent! We are so excited to have you here."

    self.create({name: user_name, email: user_email, occupation: user_occupation, age: user_age, password: user_password, balance: user_balance})
  end

 
 

  def self.user_login
    #verifies email and stores it
    user_email = verify_email

    #verifies that the password matches the account password
    verify_password(user_email)

    current_user = self.find_by email: user_email

    puts "\nWelcome back #{current_user.name}! Hope you have been saving."
    
    current_user
  end
#User class ends
end

 ####helper methods######
def create_password
  user_password = ""
  loop do
      puts "\nCreate a password"
      user_password = gets.chomp

      puts "\nConfirm password"
      user_password_confirm = gets.chomp
      if user_password != user_password_confirm
        puts "\nPasswords don't match! Please try again ;)"
        puts "========================================="
      end

      break if user_password == user_password_confirm
    end
  user_password
end


def verify_email
    user_email = ""
    loop do 
      puts "\nInput your email:"
      user_email = gets.chomp 
      if (User.find_by email: user_email) == nil 
        puts "\nThat e-mail doesn't match anything in our records :(. Please try again"
        puts "=============================================="
      end
     break if (User.find_by email: user_email) != nil 
    end

    user_email 
end


def verify_password(user_email)
  user_info = User.find_by email: user_email

  user_password = ""

  loop do 
    puts "\nInput your password:"
    user_password = gets.chomp 
    if user_info.password != user_password
      puts "\nSorry, incorrect password. Please try again."
      puts "=============================================="
    end
    break if user_info.password == user_password 
  end

end


def create_goal(user)
    
  puts "\nBriefly describe your goal:"
  user_description = gets.chomp 

  puts "\nHow much money would you like to save this month?"
  user_amount = gets.chomp.to_f 

  puts "Congrats! You just created a new goal. You want to save $#{user_amount} for the purpose of #{user_description}. :)"

  Goal.create(description: user_description, amount: user_amount, user_id: user.id)
end

def view_goal(user)
  goals_array = Goal.where(:user_id => user.id)
  puts "Your current goals are:"
  goals_array.each_with_index do |goal, index|
    puts "#{index+1}. You want to save $#{goal.amount} for the purpose of #{goal.description}."
  end
end