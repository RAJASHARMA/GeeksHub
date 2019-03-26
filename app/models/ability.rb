class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)
      if user.has_role? :admin
        can :manage, :all
    elsif user.has_role? :moderator
    	can :read, Articles
    	can :create, Articles
    	cannnot :destroy, Articles Comments
    	# cannot :destroy, Comments
    	
      else
        can :read, :all
        can :create, Articles Comments
        # can :create, Comments 
      end
  end
end
