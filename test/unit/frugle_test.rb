require 'test_helper'

class FrugleTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Frugle.new.valid?
  end
end
