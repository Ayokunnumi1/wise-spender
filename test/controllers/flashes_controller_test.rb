require 'test_helper'

class FlashesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get flashes_index_url
    assert_response :success
  end
end
