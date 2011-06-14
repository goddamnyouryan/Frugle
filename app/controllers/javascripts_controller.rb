class JavascriptsController < ApplicationController
  respond_to :js
  
  def rep_states
    @subcategories = Subcategory.all
  end
  
  def show
    @subcategories = Subcategory.all
  end
  
end
