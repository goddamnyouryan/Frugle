class JavascriptsController < ApplicationController
  respond_to :js
  
  def show
    @subcategories = Subcategory.all
  end
  
end
