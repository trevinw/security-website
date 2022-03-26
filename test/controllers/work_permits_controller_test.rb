require "test_helper"

class WorkPermitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @work_permit = work_permits(:one)
  end

  test "should get index" do
    get work_permits_url
    assert_response :success
  end

  test "should get new" do
    get new_work_permit_url
    assert_response :success
  end

  test "should create work_permit" do
    assert_difference("WorkPermit.count") do
      post work_permits_url, params: { work_permit: { alternative_contact: @work_permit.alternative_contact, category: @work_permit.category, end_date: @work_permit.end_date, needs_bypass: @work_permit.needs_bypass, notes: @work_permit.notes, number: @work_permit.number, seh_representative: @work_permit.seh_representative, start_date: @work_permit.start_date, status: @work_permit.status, work_description: @work_permit.work_description, work_location: @work_permit.work_location } }
    end

    assert_redirected_to work_permit_url(WorkPermit.last)
  end

  test "should show work_permit" do
    get work_permit_url(@work_permit)
    assert_response :success
  end

  test "should get edit" do
    get edit_work_permit_url(@work_permit)
    assert_response :success
  end

  test "should update work_permit" do
    patch work_permit_url(@work_permit), params: { work_permit: { alternative_contact: @work_permit.alternative_contact, category: @work_permit.category, end_date: @work_permit.end_date, needs_bypass: @work_permit.needs_bypass, notes: @work_permit.notes, number: @work_permit.number, seh_representative: @work_permit.seh_representative, start_date: @work_permit.start_date, status: @work_permit.status, work_description: @work_permit.work_description, work_location: @work_permit.work_location } }
    assert_redirected_to work_permit_url(@work_permit)
  end

  test "should destroy work_permit" do
    assert_difference("WorkPermit.count", -1) do
      delete work_permit_url(@work_permit)
    end

    assert_redirected_to work_permits_url
  end
end
