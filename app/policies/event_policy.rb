class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_team
        scope.where(team: user.members.first.team)
      end
    end
  end

  def show
    user.has_team && user.members.first.team == record.team
  end

  def new?
    create?
  end

  def create?
    user.manager
  end

  def edit?
    update?
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
