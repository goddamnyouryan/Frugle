require 'test_helper'

class FruglesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Frugle.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Frugle.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Frugle.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to frugle_url(assigns(:frugle))
  end

  def test_edit
    get :edit, :id => Frugle.first
    assert_template 'edit'
  end

  def test_update_invalid
    Frugle.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Frugle.first
    assert_template 'edit'
  end

  def test_update_valid
    Frugle.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Frugle.first
    assert_redirected_to frugle_url(assigns(:frugle))
  end

  def test_destroy
    frugle = Frugle.first
    delete :destroy, :id => frugle
    assert_redirected_to frugles_url
    assert !Frugle.exists?(frugle.id)
  end
end
