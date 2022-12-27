# frozen_string_literal: true

require 'test_helper'

class JobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job = jobs(:one)
    @user = users(:one)
    @job_template = job_templates(:one)
    sign_in @user
  end

  test 'should get index' do
    get jobs_url
    assert_response :success
  end

  test 'should get new' do
    get new_job_url
    assert_response :success
  end

  test 'should create job' do
    assert_difference('Job.count') do
      post jobs_url,
           params: { job: { job_template_id: @job_template.id, account_id: @job.account_id, customer_id: @job.customer_id,
                            date_and_time: @job.date_and_time, estimated_hours: @job.estimated_hours, revenue: @job.revenue, total_hours: @job.total_hours } }
    end

    assert_redirected_to job_url(Job.last)
  end

  test 'should show job' do
    get job_url(@job)
    assert_response :success
  end

  test 'should get edit' do
    get edit_job_url(@job)
    assert_response :success
  end

  test 'should update job' do
    patch job_url(@job),
          params: { job: { job_template_id: @job_template.id, account_id: @job.account_id, customer_id: @job.customer_id,
                           date_and_time: @job.date_and_time, estimated_hours: @job.estimated_hours, revenue: @job.revenue, total_hours: @job.total_hours } }
    assert_redirected_to job_url(@job)
  end

  test 'should destroy job' do
    assert_difference('Job.count', -1) do
      delete job_url(@job)
    end

    assert_redirected_to jobs_url
  end
end
