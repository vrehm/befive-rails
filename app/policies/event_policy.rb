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

end
