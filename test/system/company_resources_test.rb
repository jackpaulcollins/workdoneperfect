# frozen_string_literal: true

require 'application_system_test_case'

class CompanyResourcesTest < ApplicationSystemTestCase
  setup do
    @company_resource = company_resources(:one)
    @user = users(:one)
    login_as(@user)
  end

  test 'visiting the index' do
    visit company_resources_url
    assert_selector 'h1', text: 'Company Resources'
  end

  test 'creating a Company resource' do
    visit company_resources_url
    click_on 'New Company Resource', match: :first

    fill_in 'Description', with: @company_resource.description
    fill_in 'Name', with: @company_resource.name
    click_on 'Create Company resource'

    assert_text 'Company Resource was successfully created'
    assert_selector 'h1', text: 'Company Resources'
  end

  test 'updating a Company resource' do
    visit company_resource_url(@company_resource)
    click_on 'Edit', match: :first

    fill_in 'Description', with: @company_resource.description
    fill_in 'Name', with: @company_resource.name
    click_on 'Update Company resource'

    assert_text 'Company Resource was successfully updated'
    assert_selector 'h1', text: 'Resources'
  end

  test 'destroying a Company resource' do
    visit edit_company_resource_url(@company_resource)
    click_on 'Delete', match: :first
    click_on 'Confirm'

    assert_text 'Company Resource was successfully destroyed'
  end
end
