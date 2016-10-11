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

  def sent?
    record.first.event.team.user == user
  end

  def validated?
    true
  end

  def refused?
    true
  end

  private

  def user_is_team_manager?
    record.event.team.user == user
  end

  def user_is_participation_user?
    record.user == user
  end
end
