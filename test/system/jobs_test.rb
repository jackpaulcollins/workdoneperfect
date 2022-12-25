require "application_system_test_case"

class JobsTest < ApplicationSystemTestCase
  setup do
    @job = jobs(:one)
    @user = users(:one)
    @job_template = job_templates(:one)
    login_as(@user)
  end

  test "visiting the index" do
    visit jobs_url
    assert_selector "h1", text: "Jobs"
  end

  test "creating a Job" do
    visit jobs_url
    click_on "New Job"
    find(".choices__item--selectable").click
    find("#choices--customer-select-item-choice-1").click
    find("#job_job_template_id").click
    find("option[value='#{@job_template.id}']").click
    fill_in "Date and time", with: @job.date_and_time
    fill_in "Revenue", with: 100
    fill_in "Estimated hours", with: 8
    fill_in "Total hours", with: 8
    click_on "Schedule Job"

    assert_text "Job was successfully created"
    assert_selector "h1", text: "Jobs"
  end

  test "updating a Job" do
    visit job_url(@job)
    click_on "Edit", match: :first
    find("#job_job_template_id").click
    find("option[value='#{@job_template.id}']").click
    fill_in "Estimated hours", with: @job.estimated_hours + 1
    fill_in "Total hours", with: @job.total_hours
    click_on "Schedule Job"

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
