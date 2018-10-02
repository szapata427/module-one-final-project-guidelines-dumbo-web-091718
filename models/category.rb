class Category < ActiveRecord::Base
  has_one :goal
  has_many :budget_transaction
  has_many :user, through: :budget_transaction




end

def create_category
  if Category.all == []
    Category.create(name: "Rent/Mortage", priority: 5, fixed: true)
    Category.create(name: "Phone Bill", priority: 4, fixed: true)
    Category.create(name: "Gym Membership", priority: 3, fixed: true)
    Category.create(name: "Grocery", priority: 5, fixed: false)
    Category.create(name: "Transportation", priority: 3, fixed: false)
    Category.create(name: "Dining out", priority: 2, fixed: false)
    Category.create(name: "Miscellaneous", priority: 2, fixed: false)
  end  
end
