require 'test_helper'

class ZipcodesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Zipcode.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Zipcode.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Zipcode.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to zipcode_url(assigns(:zipcode))
  end

  def test_edit
    get :edit, :id => Zipcode.first
    assert_template 'edit'
  end

  def test_update_invalid
    Zipcode.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Zipcode.first
    assert_template 'edit'
  end

  def test_update_valid
    Zipcode.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Zipcode.first
    assert_redirected_to zipcode_url(assigns(:zipcode))
  end

  def test_destroy
    zipcode = Zipcode.first
    delete :destroy, :id => zipcode
    assert_redirected_to zipcodes_url
    assert !Zipcode.exists?(zipcode.id)
  end
end
