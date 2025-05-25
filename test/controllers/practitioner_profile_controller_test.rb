require "test_helper"

class PractitionerProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get practitioner_profile_show_url
    assert_response :success
  end

  test "should get edit" do
    get practitioner_profile_edit_url
    assert_response :success
  end

  test "should get update" do
    get practitioner_profile_update_url
    assert_response :success
  end
end
