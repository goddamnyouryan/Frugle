require 'test_helper'

class BusinessesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Business.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Business.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Business.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to business_url(assigns(:business))
  end

  def test_edit
    get :edit, :id => Business.first
    assert_template 'edit'
  end

  def test_update_invalid
    Business.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Business.first
    assert_template 'edit'
  end

  def test_update_valid
    Business.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Business.first
    assert_redirected_to business_url(assigns(:business))
  end

  def test_destroy
    business = Business.first
    delete :destroy, :id => business
    assert_redirected_to businesses_url
    assert !Business.exists?(business.id)
  end
end
