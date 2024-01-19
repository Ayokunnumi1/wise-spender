class Income < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end