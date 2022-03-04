class PublicationPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end

    def resolve
      # scope.where(:description.include?(params[:query]))
      scope.all
      # For a multi-tenant SaaS app, you may want to use:
      # scope.where(user: user)
    end
  end

  def index_owner?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    true
  end

  def edit
    update?
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
