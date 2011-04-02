class JavascriptsController < ApplicationController
  
  def show
    @subcategories = Subcategory.all
    respond_to do |format|
          format.js   # foo/bar.js.erb
        end
  end
end
