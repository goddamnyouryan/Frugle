require 'test_helper'

class ZipcodeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Zipcode.new.valid?
  end
end
