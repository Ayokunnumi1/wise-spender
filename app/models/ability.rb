class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :destroy, Expense, author_id: author.id
    can :destroy, Category, user_id: user.id

    return unless user.persisted?

    can :manage, Expense, author_id: author.id
    can :manage, Category, user_id: user.id
  end
end
