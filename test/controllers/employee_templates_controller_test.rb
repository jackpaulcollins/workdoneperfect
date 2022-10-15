require "test_helper"

class EmployeeTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee_template = employee_templates(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get employee_templates_url
    assert_response :success
  end

  test "should get new" do
    get new_employee_template_url
    assert_response :success
  end

  test "should create employee_template" do
    assert_difference("EmployeeTemplate.count") do
      post employee_templates_url, params: {employee_template: {account_id: @employee_template.account_id, title: "Unique Title"}}
    end

    assert_redirected_to employee_template_url(EmployeeTemplate.last)
  end

  test "should show employee_template" do
    get employee_template_url(@employee_template)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_template_url(@employee_template)
    assert_response :success
  end

  test "should update employee_template" do
    patch employee_template_url(@employee_template), params: {employee_template: {account_id: @employee_template.account_id, title: @employee_template.title}}
    assert_redirected_to employee_template_url(@employee_template)
  end

  test "should destroy employee_template" do
    assert_difference("EmployeeTemplate.count", -1) do
      delete employee_template_url(@employee_template)
    end

    assert_redirected_to employee_templates_url
  end
end
