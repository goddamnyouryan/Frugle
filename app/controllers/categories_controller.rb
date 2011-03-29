class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @subcategories = @category.subcategories
    @subcategory = @category.subcategories.new
  end

  def new
    @category = Category.new
    @categories = Category.all
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
    redirect_to categories_url, :notice => "Successfully destroyed category."
  end
end
