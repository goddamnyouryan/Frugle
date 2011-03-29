require 'test_helper'

class SubcategoriesControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Subcategory.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Subcategory.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end

  def test_destroy
    subcategory = Subcategory.first
    delete :destroy, :id => subcategory
    assert_redirected_to root_url
    assert !Subcategory.exists?(subcategory.id)
  end
end
