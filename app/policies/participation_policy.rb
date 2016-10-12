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

  def send_all?
    record.first.event.team.user == user
  end

  def validate?
    user_is_participation_user?
  end

  def refuse?
    user_is_participation_user?
  end

  def waiting_list?
    user_is_team_manager?
  end

  private

  def user_is_team_manager?
    record.event.team.user == user
  end

  def user_is_participation_user?
    record.user == user
  end
end
