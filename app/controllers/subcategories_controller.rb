class SubcategoriesController < ApplicationController
  def new
    @subcategory = Subcategory.new
  end
  
  def show
    @subcategory = Subcategory.find(params[:id])
  end

  def create
    @category = Category.find(params[:category_id])
    @subcategory = @category.subcategories.create(params[:subcategory])
    if @subcategory.save
      redirect_to @category, :notice => "Successfully created subcategory."
    else
      render :action => 'new'
    end
  end

  def destroy
    @subcategory = Subcategory.find(params[:id])
    @subcategory.destroy
    redirect_to root_url, :notice => "Successfully destroyed subcategory."
  end
  
  def toggle
    render :update do |page|
      page.visual_effect :toggle_blind, 'subcategories'
    end
  end
  
end
