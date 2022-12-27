# frozen_string_literal: true

require "test_helper"

class ResourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company_resource = company_resources(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get company_resources_url
    assert_response :success
  end

  test "should get new" do
    get new_company_resource_url
    assert_response :success
  end

  test "should create company_resource" do
    assert_difference("CompanyResource.count") do
      post company_resources_url,
        params: {company_resource: {account_id: @company_resource.account_id, description: @company_resource.description,
                                    name: @company_resource.name}}
    end

    assert_redirected_to company_resource_url(CompanyResource.last)
  end

  test "should show company_resource" do
    get company_resource_url(@company_resource)
    assert_response :success
  end

  test "should get edit" do
    get edit_company_resource_url(@company_resource)
    assert_response :success
  end

  test "should update resource" do
    patch company_resource_url(@company_resource),
      params: {company_resource: {account_id: @company_resource.account_id, description: @company_resource.description,
                                  name: @company_resource.name}}
    assert_redirected_to company_resource_url(@company_resource)
  end

  test "should destroy company_resource" do
    assert_difference("CompanyResource.count", -1) do
      delete company_resource_url(@company_resource)
    end

    assert_redirected_to company_resources_url
  end
end
