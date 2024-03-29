# frozen_string_literal: true

require "application_system_test_case"

class JobsTest < ApplicationSystemTestCase
  setup do
    @job = jobs(:incomplete)
    @user = users(:one)
    @job_template = job_templates(:one)
    login_as(@user)
  end

  test "visiting the index" do
    visit jobs_url
    assert_selector "h1", text: "Jobs"
  end

  test "creating a Job" do
    visit new_job_url
    select_box = find(".choices__list--single")
    select_box.click
    option = find(".choices__item--selectable", text: "MyString")
    option.click
    find("#job_job_template_id").click
    find("option[value='#{@job_template.id}']").click
    fill_in "Date and time", with: @job.date_and_time
    fill_in "Estimated hours", with: 8
    click_on "Save to Schedule"

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
    click_on "Save"

    assert_text "Job was successfully updated"
    assert_selector "h1", text: "Jobs"
  end

  test "destroying a Job" do
    visit edit_job_url(@job)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Job was successfully destroyed"
  end

  test "Cannot complete a job when details are missing" do
    @job.update_columns(estimated_hours: nil, revenue: nil, total_hours: nil)
    visit job_url(@job)
    assert has_button?("Mark Complete")
    click_on "Mark Complete"
    assert_text "Total hours can't be blank, Revenue can't be blank"
  end

  test "Can complete a job after filling in missing details" do
    @job.update_columns(revenue: nil, total_hours: nil)
    visit job_url(@job)
    assert has_button?("Mark Complete")
    click_on "Mark Complete"
    assert_text "Total hours can't be blank, Revenue can't be blank"

    # submitted either should update both values
    find("#total-hours-field").fill_in with: 2
    find("#revenue-field").fill_in with: 100
    find("#total-hours-field-sbumit").click
    assert_text "Job was successfully updated."
    find("#complete-submit", wait: 2).click
    assert_text "Job was successfully marked complete."
  end

  test "Can complete a job when everything ok" do
    @job.update_columns(estimated_hours: 8, revenue: 100, total_hours: 8)
    visit job_url(@job)
    assert has_button?("Mark Complete")
    find("#complete-submit", wait: 2).click
    assert_text "Job was successfully marked complete."
  end
end
