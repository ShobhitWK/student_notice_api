# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    if user.present?

      if user.role.name == "admin"
        can :manage, :all
      end

      if user.role.name == "teacher"
        can %i[create read update destroy], Notice, user: user
        can %[read], User
      end

      if user.role.name == "student"
        can :read, Notice
        can :read, User
      end

    end
  end
end
