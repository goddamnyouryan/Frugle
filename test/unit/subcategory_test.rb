require 'test_helper'

class SubcategoryTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Subcategory.new.valid?
  end
end
