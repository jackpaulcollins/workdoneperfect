# frozen_string_literal: true

require 'application_system_test_case'

class EmployeesTest < ApplicationSystemTestCase
  setup do
    @employee = employees(:one)
    @user = users(:one)
    login_as(@user)
  end

  test 'visiting the index' do
    visit employees_url
    assert_selector 'h1', text: 'Employees'
  end

  test 'creating an Employee' do
    visit employees_url
    click_on 'New Employee'

    select 'MyString', from: 'employee[employee_template_id]'
    fill_in 'Final date', with: @employee.final_date
    fill_in 'First name', with: @employee.first_name
    fill_in 'Last name', with: @employee.last_name
    fill_in 'Start date', with: @employee.start_date
    fill_in 'MyString', with: attribute_answers(:one).answer
    click_on 'Create Employee'

    assert_text 'Employee was successfully created'
    assert_selector 'h1', text: 'Employees'
  end

  test 'updating an Employee' do
    visit employee_url(@employee)
    click_on 'Edit', match: :first
    fill_in 'First name', with: 'new first name'

    click_on 'Update Employee'

    assert_text 'Employee was successfully updated.'
    assert_selector 'h1', text: 'Employees'
  end

  test 'destroying an Employee' do
    visit edit_employee_url(@employee)
    click_on 'Delete', match: :first
    click_on 'Confirm'

    assert_text 'Employee was successfully destroyed'
  end
end
