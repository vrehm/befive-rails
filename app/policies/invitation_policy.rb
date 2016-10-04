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
    user.teams.first == record.team
  end

end
