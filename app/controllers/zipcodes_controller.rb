class ZipcodesController < ApplicationController

  def new
    @zipcode = Zipcode.new
  end

  def create
    @neighborhood = Neighborhood.find(params[:neighborhood_id].keys[0])
    @zipcode = @neighborhood.zipcodes.create(params[:zipcode])
    if @zipcode.save
      redirect_to edit_neighborhood_path(@neighborhood), :notice => "Successfully created zipcode."
    else
      render :action => 'new'
    end
  end

  def destroy
    @zipcode = Zipcode.find(params[:id])
    @neighborhood = Neighborhood.find @zipcode.neighborhood_id
    @zipcode.destroy
    redirect_to edit_neighborhood_path(@neighborhood), :notice => "Successfully destroyed zipcode."
  end
end
