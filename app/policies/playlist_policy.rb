class PlaylistPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def destroy?
    @record.user_id == user.id
  end

  def add_a_user?
    true
  end

  def shaker?
    true
  end

  def add_a_ingredient?
    true
  end
end
