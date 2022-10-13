require "application_system_test_case"

class EmployeesTest < ApplicationSystemTestCase
  setup do
    @employee = employees(:one)
  end

  test "visiting the index" do
    visit employees_url
    assert_selector "h1", text: "Employees"
  end

  test "creating a Employee" do
    visit employees_url
    click_on "New Employee"

    fill_in "Account", with: @employee.account_id
    fill_in "Employee template", with: @employee.employee_template_id
    fill_in "Final date", with: @employee.final_date
    fill_in "First name", with: @employee.first_name
    fill_in "Last name", with: @employee.last_name
    fill_in "Start date", with: @employee.start_date
    click_on "Create Employee"

    assert_text "Employee was successfully created"
    assert_selector "h1", text: "Employees"
  end

  test "updating a Employee" do
    visit employee_url(@employee)
    click_on "Edit", match: :first

    fill_in "Account", with: @employee.account_id
    fill_in "Employee template", with: @employee.employee_template_id
    fill_in "Final date", with: @employee.final_date
    fill_in "First name", with: @employee.first_name
    fill_in "Last name", with: @employee.last_name
    fill_in "Start date", with: @employee.start_date
    click_on "Update Employee"

    assert_text "Employee was successfully updated"
    assert_selector "h1", text: "Employees"
  end

  test "destroying a Employee" do
    visit edit_employee_url(@employee)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Employee was successfully destroyed"
  end
end
