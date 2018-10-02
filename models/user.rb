class User < ActiveRecord::Base
  has_many :budget_transaction
  has_many :goal
  has_many :category, through: :budget_transaction

  def self.create_new_user
    puts "Please input your full name"
    user_name = gets.chomp

    puts "\nEnter your email:"
    user_email = gets.chomp

    user_password = create_password
    # create_password is a helper method to loop if passwords dont match.

    puts "\nWhat is your occupation?"
    user_occupation = gets.chomp

    puts "\nEnter your age:"
    user_age = gets.chomp

    puts "\nWelcome to Every Cent! We are so excited to have you here"

    self.create({name: user_name, email: user_email, occupation: user_occupation, age: user_age, password: user_password})
  end
end

def create_password
  user_password = ""
  loop do
      puts "\nCreate a password"
      user_password = gets.chomp

      puts "\nConfirm password"
      user_password_confirm = gets.chomp
      if user_password != user_password_confirm
        puts "Passwords don't match! Please try again ;)"
      end

      break if user_password == user_password_confirm
    end
  user_password
end
