# frozen_string_literal: true

require "application_system_test_case"

class EmployeeTemplatesTest < ApplicationSystemTestCase
  setup do
    @employee_template = employee_templates(:one)
    @user = users(:one)
    login_as(@user)
  end

  test "visiting the index" do
    visit employee_templates_url
    assert_selector "h1", text: "Employee Templates"
  end

  test "creating an EmployeeTemplate" do
    visit employee_templates_url
    find("#new-employee-template-button").click

    fill_in "employee_template[title]", with: "New Cool Template"
    click_on "Create Employee template"

    assert_text "Employee template was successfully created"
    assert_selector "h1", text: "Employee Templates"
  end

  test "updating an EmployeeTemplate" do
    visit employee_template_url(@employee_template)
    click_on "Edit", match: :first

    fill_in "employee_template[title]", with: "new template"
    click_on "Update Employee template"

    assert_text "Employee template was successfully updated"
    assert_selector "h1", text: "Employee Templates"
  end

  test "destroying an EmployeeTemplate" do
    visit edit_employee_template_url(@employee_template)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Employee template was successfully destroyed"
  end
end
