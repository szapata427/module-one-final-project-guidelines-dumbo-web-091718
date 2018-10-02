require_relative '../config/environment'

require 'pry'


puts "HELLO WORLD"

puts " Welcome to Every Cent! Do you have an account with us?"
puts "1.Yes \n2.No"
account_active = gets.chomp.downcase
# binding.pry

if account_active == "no"
  test_user = User.create_new_user
  end

  puts test_user
