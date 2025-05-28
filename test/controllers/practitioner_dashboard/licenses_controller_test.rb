require "test_helper"

class PractitionerDashboard::LicensesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get practitioner_dashboard_licenses_show_url
    assert_response :success
  end

  test "should get create" do
    get practitioner_dashboard_licenses_create_url
    assert_response :success
  end

  test "should get success" do
    get practitioner_dashboard_licenses_success_url
    assert_response :success
  end

  test "should get cancel" do
    get practitioner_dashboard_licenses_cancel_url
    assert_response :success
  end
end
