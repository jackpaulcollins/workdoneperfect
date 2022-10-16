require "application_system_test_case"

class EmployeeAttributesTest < ApplicationSystemTestCase
  setup do
    @employee_attribute = employee_attributes(:one)
    @user = users(:one)
    login_as(@user)
  end

  test "visiting the index" do
    visit employee_attributes_url
    assert_selector "h1", text: "Employee Attributes"
  end

  test "creating a Employee attribute" do
    visit new_employee_template_url
    find(:xpath, "/html/body/div[1]/div[2]/div/div[2]/form/button").click
    assert_selector "label", text: "Attribute name"
    fill_in "employee_template[title]", with: "test", wait: 1
    fill_in "attribute_name", with: "text"
    select "text", from: "data_type"
    click_on "Create Employee template"
    assert_text "Employee template was successfully created."
    assert_selector "h1", text: "Employee Templates"
  end

  test "updating a Employee attribute" do
    visit edit_employee_template_url(@employee_attribute.employee_template)
    fill_in "employee_template[title]", with: "test", wait: 1
    fill_in "attribute_name", with: "new text"
    select "text", from: "data_type"
    click_on "Update Employee template"
    assert_text "Employee template was successfully updated."
    assert_selector "h1", text: "Employee Templates"
  end
end
