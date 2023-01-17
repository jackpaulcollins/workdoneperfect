class JobPolicy < ApplicationPolicy
  # https://github.com/varvet/pundit
  # See ApplicationPolicy for defaults

  class Scope < Scope
    attr_reader :account_user, :scope

    def initialize(account_user, scope)
      @account_user = account_user
      @scope = scope
    end

    def employee
      account_user.user.employee
    end

    def resolve
      if account_user.admin?
        scope.all
      else
        scope.by_employee(employee.id)
      end
    end
  end

  def employee
    account_user.user.employee
  end

  def index?
    account_user.admin? || account_user.employee?
  end

  def show?
    account_user.admin? || record.employee_jobs.pluck(:employee_id).include?(employee.id)
  end

  def create?
    account_user.admin?
  end

  def new?
    account_user.admin?
  end

  def update?
    account_user.admin? || record.employee_jobs.pluck(:employee_id).include?(employee.id)
  end

  def destroy?
    account_user.admin?
  end

  # https://github.com/varvet/pundit#strong-parameters
  def permitted_attributes
    if account_user.admin?
      [:title, :body, :tag_list]
    else
      [:tag_list]
    end
  end
end
