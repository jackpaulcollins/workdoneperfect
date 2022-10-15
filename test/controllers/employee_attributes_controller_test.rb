require "test_helper"

class EmployeeAttributesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee_attribute = employee_attributes(:one)
  end

  test "should create employee_attribute" do
    assert_difference("EmployeeAttribute.count") do
      post employee_attributes_url, params: {employee_attribute: {employee_template_id: @employee_attribute.employee_template_id, name: @employee_attribute.name}}
    end

    assert_redirected_to employee_attribute_url(EmployeeAttribute.last)
  end

  test "should show employee_attribute" do
    get employee_attribute_url(@employee_attribute)
    assert_response :success
  end

  # TODO: right tests for actual partials

  test "should update employee_attribute" do
    patch employee_attribute_url(@employee_attribute), params: {employee_attribute: {employee_template_id: @employee_attribute.employee_template_id, name: @employee_attribute.name}}
    assert_redirected_to employee_attribute_url(@employee_attribute)
  end

  test "should destroy employee_attribute" do
    assert_difference("EmployeeAttribute.count", -1) do
      delete employee_attribute_url(@employee_attribute)
    end

    assert_redirected_to employee_attributes_url
  end
end
