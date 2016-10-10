class ParticipationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  
  def select?
    user_is_team_manager?
  end

  def unselect?
    user_is_team_manager?
  end

  private

  def user_is_team_manager?
    record.event.team.user == user
  end
end
