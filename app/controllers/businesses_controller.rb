class BusinessesController < ApplicationController
  def index
    @businesses = Business.all
  end

  def show
    @business = Business.find(params[:id])
    @frugles = @business.frugles
    @map = GMap.new("map_div")
              @map.control_init(:large_map => true,:map_type => true)
              @map.center_zoom_init([@business.latitude,@business.longitude],15)
              @map.overlay_init(GMarker.new([@business.latitude,@business.longitude],:title => "#{@business.name}", :info_window => "#{@business.name} <br /> #{@business.address}<br />#{@business.zip}<br />#{@business.phone}"))
    if user_signed_in?
      unless current_user.role == "business"
        @follow = Follow.find_by_user_id_and_business_id(current_user.id, @business.id)
      end
    end
  end

  def new
    @business = Business.new
  end

  def create
    @phone_number = [params[:business][:phone][:area_code], params[:business][:phone][:first_three_digits], params[:business][:phone][:second_four_digits]].reject(&:blank?).join('.')
    @business = Business.find_or_create_by_phone("#{@phone_number}")
    if @business.name == nil
      @business.name = ""
    end
    @frugle_hear_about_options = [['From a Local Frugle Rep', 'rep'], ['Spoke to another local business owner', 'owner'], ['Searching the Internet', 'internet'], ['Flyer or brochure', 'flyer'], ['Saw a window sticker', 'sticker'], ['Other', 'other']]
    @business_role_options = [['Store Owner', 'owner'], ['Store Employee', 'employee'], ['Other', 'other']]
    render :update do |page|
			page.replace_html "business_form", :partial => "businesses/form", :locals => { :business => @business }
	  end
  end

  def edit
    @business = Business.find(params[:id])
  end

  def update
    @zipcode = Zipcode.find_by_zip(params[:business][:zip])
    @frugle_hear_about_options = [['From a Local Frugle Rep', 'rep'], ['Spoke to another local business owner', 'owner'], ['Searching the Internet', 'internet'], ['Flyer or brochure', 'flyer'], ['Saw a window sticker', 'sticker'], ['Other', 'other']]
    unless @zipcode == nil
      @business = Business.find(params[:id])
      unless @business.user.nil?
        if @business.update_attributes(params[:business])
          redirect_to root_path, :notice  => "Successfully updated business info."
        end
      else
      @user = User.create(:email => params[:business][:email], :password => params[:business][:password], :role => "business")
      if @business.update_attributes(params[:business])
        @business.user_id = @user.id
        @business.neighborhood_id = @zipcode.neighborhood.id
        @business.category_id = params[:business][:category_id]
        @business.subcategory_id = params[:business][:subcategory_id]
        @business.address2 = params[:business][:address2]
        @business.hear_about = params[:business][:hear_about]
        @business.contact_name = params[:business][:contact_name]
        @business.contact_number = [params[:business][:contact_number][:contact_area_code], params[:business][:contact_number][:contact_first_three_digits], params[:business][:contact_number][:contact_second_four_digits]].reject(&:blank?).join('.')
        @business.role = params[:business][:role]
        @business.save!
        sign_in_and_redirect(:user, @user)
      else
        render :action => 'edit'
      end
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
