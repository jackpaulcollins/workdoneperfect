require "test_helper"

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee = employees(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get employees_url
    assert_response :success
  end

  test "should get new" do
    get new_employee_url
    assert_response :success
  end

  test "should create employee" do
    assert_difference("Employee.count") do
      post employees_url, params: {employee: {account_id: @employee.account_id, employee_template_id: @employee.employee_template_id, final_date: @employee.final_date, first_name: @employee.first_name, last_name: @employee.last_name, start_date: @employee.start_date}}
    end

    assert_redirected_to employee_url(Employee.last)
  end

  test "should show employee" do
    get employee_url(@employee)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_url(@employee)
    assert_response :success
  end

  test "should update employee" do
    patch employee_url(@employee), params: {employee: {account_id: @employee.account_id, employee_template_id: @employee.employee_template_id, final_date: @employee.final_date, first_name: @employee.first_name, last_name: @employee.last_name, start_date: @employee.start_date}}
    assert_redirected_to employee_url(@employee)
  end

  test "should destroy employee" do
    assert_difference("Employee.count", -1) do
      delete employee_url(@employee)
    end

    assert_redirected_to employees_url
  end
end
