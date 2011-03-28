require 'test_helper'

class BusinessTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Business.new.valid?
  end
end
