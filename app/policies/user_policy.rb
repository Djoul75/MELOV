class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!

    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def add_a_user?
    true
  end

  def look_for_user?
    true
  end
end
