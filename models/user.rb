class User < ActiveRecord::Base
  has_many :budget_transaction
  has_many :goal
  has_many :category, through: :budget_transaction

  def self.create_new_user
    puts "Please input your full name"
    user_name = gets.chomp

    puts "Enter your email:"
    user_email = gets.chomp

    puts "Create a password"
    user_password = gets.chomp

    puts "Confirm password"
    user_password_confirm = gets.chomp

    puts "What is your occupation?"
    user_occupation = gets.chomp

    puts "Enter your age:"
    user_age = gets.chomp

    puts "Welcome to Every Cent! We are so excited to have you here"

    self.create({name: user_name, email: user_email, occupation: user_occupation, age: user_age})
  end
end
