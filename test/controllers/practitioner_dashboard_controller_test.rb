require "test_helper"

class PractitionerDashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get practitioner_dashboard_index_url
    assert_response :success
  end
end
