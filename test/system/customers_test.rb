# frozen_string_literal: true

require "application_system_test_case"

class CustomersTest < ApplicationSystemTestCase
  setup do
    @customer = customers(:one)
    @user = users(:one)
    login_as(@user)
  end

  test "visiting the index" do
    visit customers_url
    assert_selector "h1", text: "Customers"
  end

  test "creating a Customer" do
    visit customers_url
    click_on "New Customer"

    fill_in "Account", with: @customer.account_id
    fill_in "Email", with: "exampleemail@workdoneperfect.com"
    fill_in "First name", with: @customer.first_name
    fill_in "Last name", with: @customer.last_name
    fill_in "Phone number", with: @customer.phone_number
    click_on "Create Customer"

    assert_text "Customer was successfully created"
    assert_selector "h1", text: "Customers"
  end

  test "updating a Customer" do
    visit customer_url(@customer)
    click_on "Edit", match: :first

    fill_in "Account", with: @customer.account_id
    fill_in "Email", with: @customer.email
    fill_in "First name", with: @customer.first_name
    fill_in "Last name", with: @customer.last_name
    fill_in "Phone number", with: @customer.phone_number
    click_on "Update Customer"

    assert_text "Customer was successfully updated"
    assert_selector "h1", text: "Customers"
  end

  test "destroying a Customer" do
    visit edit_customer_url(@customer)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Customer was successfully destroyed"
  end
end
