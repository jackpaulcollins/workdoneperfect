require "test_helper"

class JobPolicyTest < ActionDispatch::IntegrationTest
  setup do
    @employee = employees(:four)
    @employee_two = employees(:five)
    @job = jobs(:one)
  end

  def test_scope
  end

  def test_show
    EmployeeJob.destroy_all
    EmployeeJob.create!(job: @job, employee: @employee)
    sign_in @employee.claimed_by
    assert_permit(@employee.claimed_by.account_users.last, @job, :show)
    refute_permit(@employee_two.claimed_by.account_users.last, @job, :show)
  end

  def test_create
  end

  def test_update
  end

  def test_destroy
  end
end
