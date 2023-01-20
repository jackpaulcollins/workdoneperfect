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
    EmployeeJob.destroy_all
    EmployeeJob.create!(job: @job, employee: @employee_two)

    jobs = Pundit.policy_scope(@employee_two.claimed_by.account_users.last, Job)
    assert_equal @employee_two.jobs.count, jobs.count
    assert employee_scope_only_contains_employee_jobs?(jobs, @employee_two.employee_jobs)

    jobs = Pundit.policy_scope(@admin, Job)
    assert_equal jobs.count, Job.count
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

  private

  def employee_scope_only_contains_employee_jobs?(jobs, employee_jobs)
    employee_jobs.zip(jobs).all? do |employee_job, job|
      employee_job.job_id == job.id
    end
  end
end
