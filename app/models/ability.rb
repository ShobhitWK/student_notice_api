# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    if user.present?

      if user.role.name == "admin"
        can :manage, :all
      end

      if user.role.name == "teacher"
        can :create, Notice
      end

      if user.role.name == "student"
        can :read, Notice
      end

    end
  end
end
