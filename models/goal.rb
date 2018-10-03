class Goal < ActiveRecord::Base
  belongs_to :user
  has_one :category
 

  ##check if user has any goals
  def self.check_goals 
    
  end

end
