require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index with API information" do
    get root_url
    assert_response :success
    assert_equal "application/json; charset=utf-8", @response.content_type

    json = JSON.parse(@response.body)
    assert_equal "Calendário Litúrgico Anglicano", json["api"]
    assert_equal "1.0", json["version"]
    assert_equal "/api-docs", json["docs"]
    assert_not_nil json["endpoints"]
  end
end
