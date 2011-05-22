class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    if user_signed_in?
      if current_user.role == "admin"
        @category = Category.find(params[:id])
        @subcategories = @category.subcategories
        @subcategory = @category.subcategories.new
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def new
    if user_signed_in?
      if current_user.role == "admin"
        @category = Category.new
        @categories = Category.all
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to new_category_path, :notice => "Successfully created category."
    else
      render :action => 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to @category, :notice  => "Successfully updated category."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to new_category_path, :notice => "Successfully destroyed category."
  end
  
end
