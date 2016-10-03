class TeamPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    create?
  end

  def create?
    user.has_team ? false : true
  end

  def update?
    user_is_team_manager?
  end

  def destroy?
    user_is_team_manager?
  end

  private

  def user_is_team_manager?
    record.user == user
  end
end
