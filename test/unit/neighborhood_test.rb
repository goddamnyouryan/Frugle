require 'test_helper'

class NeighborhoodTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Neighborhood.new.valid?
  end
end
