require "test_helper"

class PractitionerDashboard::PractitionerAvailabilitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @practitioner_dashboard_practitioner_availability = practitioner_dashboard_practitioner_availabilities(:one)
  end

  test "should get index" do
    get practitioner_dashboard_practitioner_availabilities_url
    assert_response :success
  end

  test "should get new" do
    get new_practitioner_dashboard_practitioner_availability_url
    assert_response :success
  end

  test "should create practitioner_dashboard_practitioner_availability" do
    assert_difference("PractitionerDashboard::PractitionerAvailability.count") do
      post practitioner_dashboard_practitioner_availabilities_url, params: { practitioner_dashboard_practitioner_availability: { end_time: @practitioner_dashboard_practitioner_availability.end_time, start_time: @practitioner_dashboard_practitioner_availability.start_time, user_id: @practitioner_dashboard_practitioner_availability.user_id } }
    end

    assert_redirected_to practitioner_dashboard_practitioner_availability_url(PractitionerDashboard::PractitionerAvailability.last)
  end

  test "should show practitioner_dashboard_practitioner_availability" do
    get practitioner_dashboard_practitioner_availability_url(@practitioner_dashboard_practitioner_availability)
    assert_response :success
  end

  test "should get edit" do
    get edit_practitioner_dashboard_practitioner_availability_url(@practitioner_dashboard_practitioner_availability)
    assert_response :success
  end

  test "should update practitioner_dashboard_practitioner_availability" do
    patch practitioner_dashboard_practitioner_availability_url(@practitioner_dashboard_practitioner_availability), params: { practitioner_dashboard_practitioner_availability: { end_time: @practitioner_dashboard_practitioner_availability.end_time, start_time: @practitioner_dashboard_practitioner_availability.start_time, user_id: @practitioner_dashboard_practitioner_availability.user_id } }
    assert_redirected_to practitioner_dashboard_practitioner_availability_url(@practitioner_dashboard_practitioner_availability)
  end

  test "should destroy practitioner_dashboard_practitioner_availability" do
    assert_difference("PractitionerDashboard::PractitionerAvailability.count", -1) do
      delete practitioner_dashboard_practitioner_availability_url(@practitioner_dashboard_practitioner_availability)
    end

    assert_redirected_to practitioner_dashboard_practitioner_availabilities_url
  end
end
