require "application_system_test_case"

class PractitionerDashboard::PractitionerAvailabilitiesTest < ApplicationSystemTestCase
  setup do
    @practitioner_dashboard_practitioner_availability = practitioner_dashboard_practitioner_availabilities(:one)
  end

  test "visiting the index" do
    visit practitioner_dashboard_practitioner_availabilities_url
    assert_selector "h1", text: "Practitioner availabilities"
  end

  test "should create practitioner availability" do
    visit practitioner_dashboard_practitioner_availabilities_url
    click_on "New practitioner availability"

    fill_in "End time", with: @practitioner_dashboard_practitioner_availability.end_time
    fill_in "Start time", with: @practitioner_dashboard_practitioner_availability.start_time
    fill_in "User", with: @practitioner_dashboard_practitioner_availability.user_id
    click_on "Create Practitioner availability"

    assert_text "Practitioner availability was successfully created"
    click_on "Back"
  end

  test "should update Practitioner availability" do
    visit practitioner_dashboard_practitioner_availability_url(@practitioner_dashboard_practitioner_availability)
    click_on "Edit this practitioner availability", match: :first

    fill_in "End time", with: @practitioner_dashboard_practitioner_availability.end_time.to_s
    fill_in "Start time", with: @practitioner_dashboard_practitioner_availability.start_time.to_s
    fill_in "User", with: @practitioner_dashboard_practitioner_availability.user_id
    click_on "Update Practitioner availability"

    assert_text "Practitioner availability was successfully updated"
    click_on "Back"
  end

  test "should destroy Practitioner availability" do
    visit practitioner_dashboard_practitioner_availability_url(@practitioner_dashboard_practitioner_availability)
    accept_confirm { click_on "Destroy this practitioner availability", match: :first }

    assert_text "Practitioner availability was successfully destroyed"
  end
end
