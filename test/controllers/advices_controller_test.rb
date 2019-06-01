require 'test_helper'

class AdvicesControllerTest < ActionDispatch::IntegrationTest
  test "should get getAdvices" do
    get advices_getAdvices_url
    assert_response :success
  end

end
