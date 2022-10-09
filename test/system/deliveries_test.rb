require "application_system_test_case"

class DeliveriesTest < ApplicationSystemTestCase
  setup do
    @delivery = deliveries(:one)
  end

  test "visiting the index" do
    visit deliveries_url
    assert_selector "h1", text: "Deliveries"
  end

  test "should create delivery" do
    visit deliveries_url
    click_on "New delivery"

    fill_in "Category", with: @delivery.category
    check "Chemical delivery" if @delivery.chemical_delivery
    fill_in "Chemical type", with: @delivery.chemical_type
    fill_in "Company", with: @delivery.company
    fill_in "Datetime", with: @delivery.datetime
    fill_in "Destination", with: @delivery.destination
    fill_in "Notes", with: @delivery.notes
    fill_in "Seh contact", with: @delivery.seh_contact
    click_on "Create Delivery"

    assert_text "Delivery was successfully created"
    click_on "Back"
  end

  test "should update Delivery" do
    visit delivery_url(@delivery)
    click_on "Edit this delivery", match: :first

    fill_in "Category", with: @delivery.category
    check "Chemical delivery" if @delivery.chemical_delivery
    fill_in "Chemical type", with: @delivery.chemical_type
    fill_in "Company", with: @delivery.company
    fill_in "Datetime", with: @delivery.datetime
    fill_in "Destination", with: @delivery.destination
    fill_in "Notes", with: @delivery.notes
    fill_in "Seh contact", with: @delivery.seh_contact
    click_on "Update Delivery"

    assert_text "Delivery was successfully updated"
    click_on "Back"
  end

  test "should destroy Delivery" do
    visit delivery_url(@delivery)
    click_on "Destroy this delivery", match: :first

    assert_text "Delivery was successfully destroyed"
  end
end
