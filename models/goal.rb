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
  puts "\nBriefly describe your goal:"
  user_description = gets.chomp.downcase  

loop do
  puts "\nHow much money would you like to save this month?"
  user_amount = Float(gets) rescue nil
  break if user_amount != nil
  puts "\nThat is not a valid amount! Input a valid number please."
end
  puts "\nCongrats! You just created a new goal. You want to save $#{user_amount} for the purpose of #{user_description}. :)"

  Goal.create(description: user_description, amount: user_amount, user_id: user.id)
end

def view_goal(user)
  goals_array = Goal.where(:user_id => user.id)
  if goals_array == []
    puts "You currently don't have any goals :(. Create one!"
  else
    puts "\nYour current goals are:"
    goals_array.each_with_index do |goal, index|
      puts "#{index+1}. You want to save $#{goal.amount} for the purpose of #{goal.description}."
    end
  end
end

def delete_goal(user)
  
    puts "\n Already giving up? What goal would you like to delete?"
    loop do 
    view_goal(user)
    goals_array = Goal.where(:user_id => user.id)
    #adds an exit option to the end of the list of goals
    puts "#{goals_array.length + 1}. Exit: No longer wish to delete a goal."

    user_delete_response = Integer(gets) rescue nil 
    
    
    if user_delete_response == nil
      puts "Not a valid input. Please select a number from the list of goals."
    elsif user_delete_response == goals_array.length+1
      return nil  
    elsif user_delete_response <= goals_array.length && user_delete_response > 0
      goal_id = goals_array[user_delete_response-1]
      Goal.delete_all(id: goal_id)
      puts "Goal was succesfully deleted!"
      return nil 
    else 
      puts "Not a valid input. Please select a number from the list of goals."
    end 
  end
  
end
