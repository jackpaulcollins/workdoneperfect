require "application_system_test_case"

class AttributeAnswersTest < ApplicationSystemTestCase
  setup do
    @attribute_answer = attribute_answers(:one)
    @user = users(:one)
    login_as(@user)
  end

  test "visiting the index" do
    visit attribute_answers_url
    assert_selector "h1", text: "Attribute Answers"
  end

  test "creating an AttributeAnswer" do
    visit attribute_answers_url
    click_on "New Attribute Answer"

    fill_in "Answer", with: @attribute_answer.answer
    fill_in "Employee", with: @attribute_answer.employee_id
    fill_in "Employee template", with: employee_templates(:three).id
    click_on "Create Attribute answer"

    assert_text "Attribute answer was successfully created"
    assert_selector "h1", text: "Attribute Answers"
  end

  test "updating an AttributeAnswer" do
    visit attribute_answer_url(@attribute_answer)
    click_on "Edit", match: :first

    fill_in "Answer", with: @attribute_answer.answer
    fill_in "Employee", with: @attribute_answer.employee_id
    fill_in "Employee template", with: @attribute_answer.employee_template_id
    click_on "Update Attribute answer"

    assert_text "Attribute answer was successfully updated"
    assert_selector "h1", text: "Attribute Answers"
  end

  test "destroying an AttributeAnswer" do
    visit edit_attribute_answer_url(@attribute_answer)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Attribute answer was successfully destroyed"
  end
end
