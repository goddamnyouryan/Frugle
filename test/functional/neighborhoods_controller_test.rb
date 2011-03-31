require 'test_helper'

class NeighborhoodsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Neighborhood.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Neighborhood.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Neighborhood.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to neighborhood_url(assigns(:neighborhood))
  end

  def test_edit
    get :edit, :id => Neighborhood.first
    assert_template 'edit'
  end

  def test_update_invalid
    Neighborhood.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Neighborhood.first
    assert_template 'edit'
  end

  def test_update_valid
    Neighborhood.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Neighborhood.first
    assert_redirected_to neighborhood_url(assigns(:neighborhood))
  end

  def test_destroy
    neighborhood = Neighborhood.first
    delete :destroy, :id => neighborhood
    assert_redirected_to neighborhoods_url
    assert !Neighborhood.exists?(neighborhood.id)
  end
end
