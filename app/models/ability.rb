class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)
      if user.has_role? :admin
        can :manage, :all
      elsif user.has_role? :moderator
      	can :manage, Article
        can :manage, Comment
      else
        can :read, :all
        can :manage, Article, user_id: user.id
        can :manage, Comment, user_id: user.id
      end
  end


end
