class User < ActiveRecord::Base
  has_many :budget_transaction
  has_many :goal
  has_many :category, through: :budget_transaction
  

  def self.create_new_user
    prompt = TTY::Prompt.new
    user_name = ""
    loop do 
      puts "\nPlease input your full name".colorize(:blue)
      user_name = gets.chomp
      break if !(user_name.blank?)
      puts "Please input at least one character for your name :).".colorize(:red)
    end
    user_name = user_name.titleize

    user_email = prompt.ask('What is your email?') { |q| q.validate :email }

    user_password = create_password
    # create_password is a helper method to loop if passwords dont match.

    puts "\nWhat is your occupation? (Optional)".colorize(:blue)
    user_occupation = String(gets) rescue nil 

    user_age = 0
    loop do 
      puts "\nEnter your age (optional):".colorize(:blue)
      user_age = Integer(gets) rescue 0 
      break if user_age > 0
      puts "You probably need to chill and stop trying to break our code.. :)".colorize(:red)
    end

    user_balance = ""
    loop do 
      puts "\nLast step! What is your starting budget?".colorize(:blue)
      user_balance = Float(gets) rescue -1.0
      break if user_balance >= 0
      Kernel.abort("You probably don't need this app at the moment. Come through when you have at least $0...".colorize(:red))
    end
  
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
  prompt = TTY::Prompt.new
  loop do
      loop do
        puts ""
        user_password = prompt.mask("Create a password:".colorize(:blue))

      break if !user_password.blank? 
        puts "Please enter a valid password that is at least one character.".colorize(:red)
      end 
      user_password_confirm = prompt.mask("Confirm password:".colorize(:blue))
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
  prompt = TTY::Prompt.new
  loop do 
    puts ""
    user_password = prompt.mask("Input your password:".colorize(:blue))
    if user_info.password != user_password
      puts "\nSorry, incorrect password. Please try again.".colorize(:red)
      puts "=============================================="
    end
    break if user_info.password == user_password 
  end

  

end




