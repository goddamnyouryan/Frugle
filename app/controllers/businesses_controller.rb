class BusinessesController < ApplicationController
  def index
    @businesses = Business.all
  end

  def show
    @business = Business.find(params[:id])
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.find_or_create_by_phone(params[:business][:phone])
    render :update do |page|
			page.replace_html "business_form", :partial => "form"
	  end
  end

  def edit
    @business = Business.find(params[:id])
  end

  def update
    @business = Business.find(params[:id])
    @user = User.create(:email => params[:business][:email], :password => params[:business][:password], :role => "business")
    if @business.update_attributes(params[:business])
      @business.user_id = @user.id
      @business.save!
      redirect_to @business, :notice  => "Successfully updated business."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @business = Business.find(params[:id])
    @business.destroy
    redirect_to businesses_url, :notice => "Successfully destroyed business."
  end
end