class Category < ActiveRecord::Base
  has_one :goal
  has_many :budget_transaction
  has_many :user, through: :budget_transaction
end
