class User < ActiveRecord::Base
  has_many :budget_transaction
  has_many :goal
  has_many :category, through: :budget_transaction
  

  def self.create_new_user
    puts "\nPlease input your full name".colorize(:blue)
    user_name = gets.chomp
    user_name = user_name.titleize
    

      user_email = ""
    loop do 
    puts "\nEnter your email:".colorize(:blue)
    user_email = gets.chomp

    break if user_email.include?("@") && user_email.include?(".")
    puts "\nPlease input a valid email.".colorize(:red)
    end

    user_password = create_password
    # create_password is a helper method to loop if passwords dont match.

    puts "\nWhat is your occupation?".colorize(:blue)
    user_occupation = gets.chomp

    puts "\nEnter your age:".colorize(:blue)
    user_age = gets.chomp

    puts "\nLast step! What is your starting budget?".colorize(:blue)
    user_balance = gets.chomp.to_f 
    puts "Awesome! Your starting budget is #{user_balance}.".colorize(:green)

    puts "\nWelcome to Every Cent! We are so excited to have you here.".colorize(:blue)

    self.create({name: user_name, email: user_email, occupation: user_occupation, age: user_age, password: user_password, balance: user_balance})
  end

 
 

  def self.user_login
    #verifies email and stores it
    user_email = verify_email

    #verifies that the password matches the account password
    verify_password(user_email)

    current_user = self.find_by email: user_email

    puts "\nWelcome back #{current_user.name}! Hope you have been saving.".colorize(:blue)
    
    current_user
  end
#User class ends
end

 ####helper methods######
def create_password
  user_password = ""
  loop do
      puts "\nCreate a password".colorize(:blue)
      user_password = STDIN.noecho(&:gets).chomp

      puts "\nConfirm password".colorize(:blue)
      user_password_confirm = STDIN.noecho(&:gets).chomp
      if user_password != user_password_confirm
        puts "\nPasswords don't match! Please try again ;)".colorize(:red)
        puts "========================================="
      end

      break if user_password == user_password_confirm
    end
  user_password
end


def verify_email
    user_email = ""
    loop do 
      puts "\nInput your email:".colorize(:blue)
      user_email = gets.chomp 
      if (User.find_by email: user_email) == nil 
        puts "\nThat e-mail doesn't match anything in our records :(. Please try again".colorize(:red)
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
    puts "\nInput your password:".colorize(:blue)
    user_password = STDIN.noecho(&:gets).chomp 
    if user_info.password != user_password
      puts "\nSorry, incorrect password. Please try again.".colorize(:red)
      puts "=============================================="
    end
    break if user_info.password == user_password 
  end

  

end




