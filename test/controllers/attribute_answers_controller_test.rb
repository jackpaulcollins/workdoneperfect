require "test_helper"

class AttributeAnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @attribute_answer = attribute_answers(:one)
  end

  test "should get index" do
    get attribute_answers_url
    assert_response :success
  end

  test "should get new" do
    get new_attribute_answer_url
    assert_response :success
  end

  test "should create attribute_answer" do
    assert_difference("AttributeAnswer.count") do
      post attribute_answers_url, params: {attribute_answer: {answer: @attribute_answer.answer, employee_id: @attribute_answer.employee_id, employee_template_id: employee_templates(:two).id}}
    end

    assert_redirected_to attribute_answer_url(AttributeAnswer.last)
  end

  test "should show attribute_answer" do
    get attribute_answer_url(@attribute_answer)
    assert_response :success
  end

  test "should get edit" do
    get edit_attribute_answer_url(@attribute_answer)
    assert_response :success
  end

  test "should update attribute_answer" do
    patch attribute_answer_url(@attribute_answer), params: {attribute_answer: {answer: @attribute_answer.answer, employee_id: @attribute_answer.employee_id, employee_template_id: @attribute_answer.employee_template_id}}
    assert_redirected_to attribute_answer_url(@attribute_answer)
  end

  test "should destroy attribute_answer" do
    assert_difference("AttributeAnswer.count", -1) do
      delete attribute_answer_url(@attribute_answer)
    end

    assert_redirected_to attribute_answers_url
  end
end
