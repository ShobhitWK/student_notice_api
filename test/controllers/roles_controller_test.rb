require "test_helper"

class RolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @role = roles(:one)
  end

  test "should get index" do
    get roles_url, as: :json
    assert_response :success
  end

  test "should create role" do
    assert_difference('Role.count') do
      post roles_url, params: { role: { name: @role.name } }, as: :json
    end

    assert_response 201
  end

  test "should show role" do
    get role_url(@role), as: :json
    assert_response :success
  end

  test "should update role" do
    patch role_url(@role), params: { role: { name: @role.name } }, as: :json
    assert_response 200
  end

  test "should destroy role" do
    assert_difference('Role.count', -1) do
      delete role_url(@role), as: :json
    end

    assert_response 204
  end
end
