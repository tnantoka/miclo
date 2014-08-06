class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    user_id = user.id

    can :read, :all
    can :manage, User, id: user_id
    can :manage, Topic, user_id: user_id
    can :manage, Post, user_id: user_id, topic: { user_id: user_id }
  end
end
