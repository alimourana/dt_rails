# frozen_string_literal: true

class OauthApplicationPolicy < ApplicationPolicy
  class Scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      internal_scope.or(manage_company_scope)
    end

    def index?
      true
    end

    def create?
      true
    end

    def update?
      manage?
    end
  
    def destroy?
      manage?
    end

    private

    attr_reader :user, :scope

    def internal_scope?
      scope.where(scopes: 'internal')
    end

    def company_employee?
      user.employee.present?
    end

    def manage_company?
      company_employee? && record.created_by == user
    end

    def manage?
      record.owner == user
    end
  end
end