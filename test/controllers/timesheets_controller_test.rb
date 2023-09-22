require "test_helper"

class TimesheetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @timesheet = timesheets(:one)
  end

  test "should get index" do
    get timesheets_url, as: :json
    assert_response :success
  end

  test "should create timesheet" do
    assert_difference("Timesheet.count") do
      post timesheets_url, params: { timesheet: { action: @timesheet.action, date: @timesheet.date, end_time: @timesheet.end_time, progress_details: @timesheet.progress_details, start_time: @timesheet.start_time, task_id: @timesheet.task_id } }, as: :json
    end

    assert_response :created
  end

  test "should show timesheet" do
    get timesheet_url(@timesheet), as: :json
    assert_response :success
  end

  test "should update timesheet" do
    patch timesheet_url(@timesheet), params: { timesheet: { action: @timesheet.action, date: @timesheet.date, end_time: @timesheet.end_time, progress_details: @timesheet.progress_details, start_time: @timesheet.start_time, task_id: @timesheet.task_id } }, as: :json
    assert_response :success
  end

  test "should destroy timesheet" do
    assert_difference("Timesheet.count", -1) do
      delete timesheet_url(@timesheet), as: :json
    end

    assert_response :no_content
  end
end
