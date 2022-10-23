require "application_system_test_case"

class ResourcesTest < ApplicationSystemTestCase
  setup do
    @resource = resources(:one)
  end

  test "visiting the index" do
    visit resources_url
    assert_selector "h1", text: "Resources"
  end

  test "creating a Resource" do
    visit resources_url
    click_on "New Resource"

    fill_in "Account", with: @resource.account_id
    fill_in "Count", with: @resource.count
    fill_in "Description", with: @resource.description
    fill_in "Name", with: @resource.name
    click_on "Create Resource"

    assert_text "Resource was successfully created"
    assert_selector "h1", text: "Resources"
  end

  test "updating a Resource" do
    visit resource_url(@resource)
    click_on "Edit", match: :first

    fill_in "Account", with: @resource.account_id
    fill_in "Count", with: @resource.count
    fill_in "Description", with: @resource.description
    fill_in "Name", with: @resource.name
    click_on "Update Resource"

    assert_text "Resource was successfully updated"
    assert_selector "h1", text: "Resources"
  end

  test "destroying a Resource" do
    visit edit_resource_url(@resource)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Resource was successfully destroyed"
  end
end
