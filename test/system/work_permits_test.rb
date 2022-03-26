require "application_system_test_case"

class WorkPermitsTest < ApplicationSystemTestCase
  setup do
    @work_permit = work_permits(:one)
  end

  test "visiting the index" do
    visit work_permits_url
    assert_selector "h1", text: "Work permits"
  end

  test "should create work permit" do
    visit work_permits_url
    click_on "New work permit"

    fill_in "Alternative contact", with: @work_permit.alternative_contact
    fill_in "Category", with: @work_permit.category
    fill_in "End date", with: @work_permit.end_date
    check "Needs bypass" if @work_permit.needs_bypass
    fill_in "Notes", with: @work_permit.notes
    fill_in "Number", with: @work_permit.number
    fill_in "Seh representative", with: @work_permit.seh_representative
    fill_in "Start date", with: @work_permit.start_date
    fill_in "Status", with: @work_permit.status
    fill_in "Work description", with: @work_permit.work_description
    fill_in "Work location", with: @work_permit.work_location
    click_on "Create Work permit"

    assert_text "Work permit was successfully created"
    click_on "Back"
  end

  test "should update Work permit" do
    visit work_permit_url(@work_permit)
    click_on "Edit this work permit", match: :first

    fill_in "Alternative contact", with: @work_permit.alternative_contact
    fill_in "Category", with: @work_permit.category
    fill_in "End date", with: @work_permit.end_date
    check "Needs bypass" if @work_permit.needs_bypass
    fill_in "Notes", with: @work_permit.notes
    fill_in "Number", with: @work_permit.number
    fill_in "Seh representative", with: @work_permit.seh_representative
    fill_in "Start date", with: @work_permit.start_date
    fill_in "Status", with: @work_permit.status
    fill_in "Work description", with: @work_permit.work_description
    fill_in "Work location", with: @work_permit.work_location
    click_on "Update Work permit"

    assert_text "Work permit was successfully updated"
    click_on "Back"
  end

  test "should destroy Work permit" do
    visit work_permit_url(@work_permit)
    click_on "Destroy this work permit", match: :first

    assert_text "Work permit was successfully destroyed"
  end
end
