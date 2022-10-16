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

  test "creating a Employee template" do
    visit employee_templates_url
    click_on "New Employee Template"

    fill_in "Account", with: @employee_template.account_id
    fill_in "Title", with: @employee_template.title
    click_on "Create Employee template"

    assert_text "Employee template was successfully created"
    assert_selector "h1", text: "Employee Templates"
  end

  test "updating a Employee template" do
    visit employee_template_url(@employee_template)
    click_on "Edit", match: :first

    fill_in "Account", with: @employee_template.account_id
    fill_in "Title", with: @employee_template.title
    click_on "Update Employee template"

    assert_text "Employee template was successfully updated"
    assert_selector "h1", text: "Employee Templates"
  end

  test "destroying a Employee template" do
    visit edit_employee_template_url(@employee_template)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Employee template was successfully destroyed"
  end
end
