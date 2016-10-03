class MemberPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.has_team ? false : true && user.members.where("pending = ?", true).size < 1
  end

  def update?
    user_is_member_team_manager?
  end

  def destroy?
    record.user == user || user_is_member_team_manager?
  end

  private

  def user_is_member_team_manager?
    record.team.user == user
  end

end
