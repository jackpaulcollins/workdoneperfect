class JobPolicy < ApplicationPolicy
  # https://github.com/varvet/pundit
  # See ApplicationPolicy for defaults

  def index?
    account_user.admin? || account_user.employee?
  end

  def show?
    account_user.admin? || account_user.employee?
  end

  def create?
    account_user.admin? || account_user.employee?
  end

  def update?
    account_user.admin? || account_user.employee?
  end

  def destroy?
    account_user.admin? || account_user.employee?
  end

  # https://github.com/varvet/pundit#strong-parameters
  def permitted_attributes
    if account_user.admin?
      [:title, :body, :tag_list]
    else
      [:tag_list]
    end
  end

  class Scope < Scope
    def resolve
      if account_user.admin?
        scope.all
      else
        scope.where
      end
    end
  end
end
