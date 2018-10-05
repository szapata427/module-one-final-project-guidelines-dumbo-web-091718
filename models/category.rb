class Category < ActiveRecord::Base
  has_one :goal
  has_many :budget_transaction
  has_many :user, through: :budget_transaction




end



def category_spending_amount(user)
  ultimate_hash = {}
  transactions_array = BudgetTransaction.where(:user_id => user.id)
  Category.where(spent: true).each do |category|
      # if category.spent == true
    total = 0
      transactions_array.each do |transactions|
        if category.id == transactions.category_id && transactions.amount < 0
            total -= transactions.amount
        end          
      end
      ultimate_hash[category.name] = total
  end
  #displaying hash values
    sorted_array = ultimate_hash.sort_by { |key, value| value}.reverse
    sorted_array.each_with_index do |category, idx|
      puts "#{idx + 1}. #{category[0]}: $#{'%.2f' % category[1]}".colorize(:yellow)
      end
    # end
end




