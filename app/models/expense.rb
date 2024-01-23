class Expense < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :category


  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :name, presence: true

  def most_recent; end
end
