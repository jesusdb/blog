# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def update?
    (@record.user_id == user.id) || user.admin?
  end

  def destroy?
    update?
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
