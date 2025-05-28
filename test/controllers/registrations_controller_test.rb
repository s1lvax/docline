require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get patient" do
    get registrations_patient_url
    assert_response :success
  end

  test "should get practitioner" do
    get registrations_practitioner_url
    assert_response :success
  end

  test "should get create_user" do
    get registrations_create_user_url
    assert_response :success
  end
end
