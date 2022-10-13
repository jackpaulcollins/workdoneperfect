require "application_system_test_case"

class JobsTest < ApplicationSystemTestCase
  setup do
    @job = jobs(:one)
  end

  test "visiting the index" do
    visit jobs_url
    assert_selector "h1", text: "Jobs"
  end

  test "creating a Job" do
    visit jobs_url
    click_on "New Job"

    fill_in "Account", with: @job.account_id
    fill_in "Customer", with: @job.customer_id
    fill_in "Date and time", with: @job.date_and_time
    fill_in "Estimated hours", with: @job.estimated_hours
    fill_in "Revenue", with: @job.revenue
    fill_in "Total hours", with: @job.total_hours
    click_on "Create Job"

    assert_text "Job was successfully created"
    assert_selector "h1", text: "Jobs"
  end

  test "updating a Job" do
    visit job_url(@job)
    click_on "Edit", match: :first

    fill_in "Account", with: @job.account_id
    fill_in "Customer", with: @job.customer_id
    fill_in "Date and time", with: @job.date_and_time
    fill_in "Estimated hours", with: @job.estimated_hours
    fill_in "Revenue", with: @job.revenue
    fill_in "Total hours", with: @job.total_hours
    click_on "Update Job"

    assert_text "Job was successfully updated"
    assert_selector "h1", text: "Jobs"
  end

  test "destroying a Job" do
    visit edit_job_url(@job)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Job was successfully destroyed"
  end
end
