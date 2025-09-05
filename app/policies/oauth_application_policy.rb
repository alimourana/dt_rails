# frozen_string_literal: true

class OauthApplicationPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present? && (record.owner == user || user.admin?)
  end

  def create?
    user.present?
  end

  def update?
    user.present? && (record.owner == user || user.admin?)
  end

  def destroy?
    user.present? && (record.owner == user || user.admin?)
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(owner: user)
      end
    end
  end
end