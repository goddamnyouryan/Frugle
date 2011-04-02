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
    @phone_number = [params[:business][:phone][:area_code], params[:business][:phone][:first_three_digits], params[:business][:phone][:second_four_digits]].reject(&:blank?).join('.')
    @business = Business.find_or_create_by_phone("#{@phone_number}")
    render :update do |page|
			page.replace_html "business_form", :partial => "form"
	  end
  end

  def edit
    @business = Business.find(params[:id])
  end

  def update
    @zipcode = Zipcode.find_by_zip(params[:business][:zip])
    unless @zipcode == nil
      @business = Business.find(params[:id])
      @user = User.create(:email => params[:business][:email], :password => params[:business][:password], :role => "business")
      if @business.update_attributes(params[:business])
        @business.user_id = @user.id
        @business.neighborhood_id = @zipcode.neighborhood.id
        @business.category_id = params[:business][:category_id]
        @business.subcategory_id = params[:business][:subcategory_id]
        @business.save!
        redirect_to @business, :notice  => "Successfully updated business."
      else
        render :action => 'edit'
      end
    else
      @business = Business.find(params[:id])
      @business.destroy
      redirect_to root_url, :notice => "We're sorry, we are currently not offering our services in your neighborhood."
    end
  end

  def destroy
    @business = Business.find(params[:id])
    @business.destroy
    redirect_to businesses_url, :notice => "Successfully destroyed business."
  end
end
