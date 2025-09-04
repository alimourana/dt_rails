# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def admin?
    ceo? || manager? || record.admin?
  end
  
  private

  def employee?
    Employee.where(user: record).exists?
  end

  def ceo?
    employee? && record.employee.position == 'CEO'
  end

  def manager?
    employee? && record.employee.position == 'Manager'
  end
end