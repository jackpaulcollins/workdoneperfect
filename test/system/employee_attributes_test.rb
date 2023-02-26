# frozen_string_literal: true

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
    visit employee_attributes_url
    find("#new-employee-attribute-button").click

    fill_in "Employee template", with: @employee_attribute.employee_template_id
    fill_in "Name", with: @employee_attribute.name
    click_on "Create Employee attribute"

    assert_text "Employee attribute was successfully created"
    assert_selector "h1", text: "Employee Attributes"
  end

  test "updating a Employee attribute" do
    visit employee_attribute_url(@employee_attribute)
    click_on "Edit", match: :first

    fill_in "Employee template", with: @employee_attribute.employee_template_id
    fill_in "Name", with: @employee_attribute.name
    click_on "Update Employee attribute"

    assert_text "Employee attribute was successfully updated"
    assert_selector "h1", text: "Employee Attributes"
  end

  test "destroying a Employee attribute" do
    visit edit_employee_attribute_url(@employee_attribute)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Employee attribute was successfully destroyed"
  end
end
