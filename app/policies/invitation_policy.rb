class InvitationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  def new?
    create?
  end

  def create?
    if user.manager
      record.team == user.teams.first
    else
      false
    end
  end

end
