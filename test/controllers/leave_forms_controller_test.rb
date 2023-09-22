require "test_helper"

class LeaveFormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @leave_form = leave_forms(:one)
  end

  test "should get index" do
    get leave_forms_url, as: :json
    assert_response :success
  end

  test "should create leave_form" do
    assert_difference("LeaveForm.count") do
      post leave_forms_url, params: { leave_form: { date_from: @leave_form.date_from, date_to: @leave_form.date_to, leave_type: @leave_form.leave_type, reason_for_leave: @leave_form.reason_for_leave, staff_id: @leave_form.staff_id } }, as: :json
    end

    assert_response :created
  end

  test "should show leave_form" do
    get leave_form_url(@leave_form), as: :json
    assert_response :success
  end

  test "should update leave_form" do
    patch leave_form_url(@leave_form), params: { leave_form: { date_from: @leave_form.date_from, date_to: @leave_form.date_to, leave_type: @leave_form.leave_type, reason_for_leave: @leave_form.reason_for_leave, staff_id: @leave_form.staff_id } }, as: :json
    assert_response :success
  end

  test "should destroy leave_form" do
    assert_difference("LeaveForm.count", -1) do
      delete leave_form_url(@leave_form), as: :json
    end

    assert_response :no_content
  end
end
