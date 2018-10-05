class Goal < ActiveRecord::Base
  belongs_to :user
  has_one :category
 


end

def total_goal_amount(user)
  goals_array = Goal.where(:user_id => user.id)
  goals_array.inject(0) { |sum, goal| sum + goal.amount }
end


def create_goal(user)
    user_amount = ""
  puts "\nBriefly describe your goal:".colorize(:blue)
  user_description = gets.chomp.downcase  

loop do
  puts "\nHow much money would you like to save this month?".colorize(:blue)
  user_amount = Float(gets) rescue 0
  break if user_amount > 0
  puts "\nThat is not a valid amount! Input a valid number please.".colorize(:red)
end
  puts "\nCongrats! You just created a new goal. You want to save $#{user_amount} for the purpose of #{user_description}. :)".colorize(:blue)

  Goal.create(description: user_description, amount: user_amount, user_id: user.id)
end


def view_goal(user)
  goals_array = Goal.where(:user_id => user.id)
  if goals_array == []
    puts "You currently don't have any goals :(. Create one!".colorize(:light_red)
  else
    puts "\nYour current goals are:".colorize(:light_blue)
    goals_array.each_with_index do |goal, index|
      puts "#{index+1}. You want to save $#{goal.amount} for the purpose of #{goal.description}.".colorize(:light_cyan)
    end
  end
end


#helper method for delete goal method
def array_of_goals_string(goals_array)
  array = []
  goals_array.each_with_index do |goal, index|
    array << "#{index+1}. You want to save $#{goal.amount} for the purpose of #{goal.description} with (id##{goal.id}).".colorize(:white)
  end
  array << "#{array.length + 1}. Exit ".colorize(:red)

end

def delete_goal(user)
  prompt = TTY::Prompt.new

  
    loop do 
    goals_array = Goal.where(:user_id => user.id)
    array_of_goal_strings = array_of_goals_string(goals_array)
    puts ""
    user_delete_response = prompt.select("Already giving up? What goal would you like to delete?".colorize(:magenta), [array_of_goal_strings])
      if user_delete_response == array_of_goal_strings.last #exit back 
        break
      else #delete the goal
        goal_index = array_of_goal_strings.index(user_delete_response)
        goal_to_delete = goals_array[goal_index]
        goal_to_delete.delete
        puts "Goal was succesfully deleted!".colorize(:light_magenta)
      end 
  end
  
end
