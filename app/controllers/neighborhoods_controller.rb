class NeighborhoodsController < ApplicationController
  def index

  end
  
  def initial
    session[:neighborhood] = params[:neighborhood_id]
    render :update do |page|
	    page.visual_effect :fade, "box", :duration=>0.25
	    page.delay(0.5) do
	      page.visual_effect :appear, "sign_up", :duration=>0.25
      end
	  end
  end

  def show
    @neighborhood = Neighborhood.find(params[:id])
    @zipcodes = @neighborhood.zipcodes
    @zipcode = @neighborhood.zipcodes.new
  end

  def new
    @neighborhood = Neighborhood.new
    @neighborhoods = Neighborhood.all
  end

  def create
    @neighborhood = Neighborhood.new(params[:neighborhood])
    if @neighborhood.save
      redirect_to @neighborhood, :notice => "Successfully created neighborhood."
    else
      render :action => 'new'
    end
  end

  def edit
    @all = Neighborhood.all
    @neighborhoods = @all.map(&:name)
    render :update do |page|
	    page.replace_html "neighborhood", :partial => "neighborhoods/neighborhood"
	  end
  end

  def update
    current_user.neighborhood_id = params[:user][:neighborhood_id]
    current_user.save!
      render :update do |page|
  	    page.replace_html "neighborhood", "#{current_user.neighborhood.name} #{link_to "(change)", edit_neighborhood_path, :remote => true}"
	    end
  end

  def destroy
    @neighborhood = Neighborhood.find(params[:id])
    @neighborhood.destroy
    redirect_to neighborhoods_url, :notice => "Successfully destroyed neighborhood."
  end
end
