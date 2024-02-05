class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :categories
  has_many :expenses, through: :categories
  has_many :incomes

  validates :name, presence: true
  validates :password, length: { minimum: 8 }, if: :password
  validates :password, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}\z/,
                                 message: 'must include at least one lowercase letter,
                                 one uppercase letter, and one digit' },
                       if: :password

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
                              message: 'must be a valid email address' }
end
