require_relative '../config/environment'

require 'pry'


puts "HELLO WORLD"

puts "Welcome to Every Cent! Do you have an account with us?"
puts "1.Yes \n2.No"
account_active = gets.chomp.downcase


if account_active == "no"
  test_user = User.create_new_user
else
  User.user_login 
end


