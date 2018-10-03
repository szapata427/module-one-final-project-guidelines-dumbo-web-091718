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

def category_spending_amount(user)
  ultimate_hash = {}
  transactions_array = BudgetTransaction.where(:user_id => user.id)
  Category.all.each do |category|
    total = 0
      transactions_array.each do |transactions|
        if category.id == transactions.category_id && transactions.amount < 0
            total -= transactions.amount
        end          
      end
      ultimate_hash[category.name] = total
  end
    sorted_array = ultimate_hash.sort_by { |key, value| value}.reverse
    sorted_array.each_with_index do |category, idx|
      puts "#{idx + 1}. #{category[0]}: $#{category[1]}"
      end
    end


