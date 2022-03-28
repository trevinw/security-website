# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    user ||= User.new

    if user.is_admin?
      can :manage, :all
    elsif user.is_security_lead?
      can :manage, :all
    elsif user.is_security_rover?
      can :read, :all
      can %i[read create update], WorkPermit
      can :create, Company
    else
      can :read, :all
    end
  end
end
