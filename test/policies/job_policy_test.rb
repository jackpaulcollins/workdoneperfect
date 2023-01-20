require "test_helper"

class JobPolicyTest < ActionDispatch::IntegrationTest
  setup do
    @employee = employees(:employee_not_admin)
    @employee_two = employees(:four)
    @job = jobs(:one)
    # We use account users for authorization, so we only need that for our admin
    @admin = account_users(:admin_not_employee)
  end

  def test_scope
  end

  def test_show
    EmployeeJob.destroy_all
    EmployeeJob.create!(job: @job, employee: @employee)
    assert_permit(@employee.claimed_by.account_users.last, @job, :show)
    refute_permit(@employee_two.claimed_by.account_users.last, @job, :show)
  end

  def test_create
    assert_permit(@admin, :job, :create)
    refute_permit(@employee_two.claimed_by.account_users.last, :job, :create)
    refute_permit(@employee.claimed_by.account_users.last, :job, :create)
  end

  def test_update
    EmployeeJob.destroy_all
    EmployeeJob.create!(job: @job, employee: @employee)
    assert_permit(@admin, @job, :update)
    assert_permit(@employee.claimed_by.account_users.last, @job, :update)
  end

  def test_destroy
    assert_permit(@admin, :job, :destroy)
    refute_permit(@employee_two.claimed_by.account_users.last, :job, :destroy)
    refute_permit(@employee.claimed_by.account_users.last, :job, :destroy)
  end
end
