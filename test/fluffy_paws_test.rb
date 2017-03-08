require 'test_helper'

class FluffyPawsTest < Minitest::Test
  include Rack::Test::Methods

  def app
    FluffyPaws::App
  end

  def test_that_it_has_a_version_number
    refute_nil ::FluffyPaws::VERSION
  end

  def test_index_response_is_ok
    get '/'
    assert last_response.ok?
  end

  def test_index_body_contains_custom_title
    get '/'
    assert_includes last_response.body, 'Holy Smokes!'
  end
end
