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
    if user_signed_in?
      flash[:notice] = "We're sorry but you need to log out first to create a business account."
      redirect_to root_path, :notice => "We're sorry but you need to log out first to create a business account"
    else
      @business = Business.new
    end
  end

  def create
    @phone_number = [params[:business][:phone][:area_code], params[:business][:phone][:first_three_digits], params[:business][:phone][:second_four_digits]].reject(&:blank?).join('.')
    @business = Business.find_or_create_by_phone("#{@phone_number}")
    charset = %w{ 0 1 2 3 4 5 6 7 8 9 0 }
    @business.verification = (0...4).map{ charset.to_a[rand(charset.size)] }.join
    @business.save!
    if @business.name == nil
      @business.name = ""
    end
    @frugle_hear_about_options = [['From a Local Frugle Rep', 'rep'], ['Spoke to another local business owner', 'owner'], ['Searching the Internet', 'internet'], ['Flyer or brochure', 'flyer'], ['Saw a window sticker', 'sticker'], ['Other', 'other']]
    @business_role_options = [['Store Owner', 'owner'], ['Store Manager', 'manager'], ['Store Employee', 'employee'], ['Other', 'other']]
    render :update do |page|
      if @business.user.nil?
			  page.replace_html "business_form", :partial => "businesses/form", :locals => { :business => @business }
		  else
		    page.replace_html "business_form", "<p style='width:500px;'>This business listing has already been claimed.  Try resetting your password #{link_to 'here', new_password_path(@business.user), :style => 'font-weight:bold'} and we’ll send you a new password to your email we have on file.  Otherwise, if you do own this business and don’t remember signing up, please contact <a href='mailto:merchants@frugle.me' style='font-weight:bold;'>merchants@frugle.me</a></p>"
	    end
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
        @user = User.create(:email => params[:business][:email], :password => params[:business][:password], :password_confirmation => params[:business][:password], :role => "business", :sex => "Male", :birthday => Date.today, :neighborhood_id => @zipcode.neighborhood_id, :first_name => params[:business][:name], :last_name => params[:business][:name])
        if @user.valid?
          @business.user_id = @user.id
          @business.name = params[:business][:name]
          @business.save!
          if @business.update_attributes(params[:business])
            @business.neighborhood_id = @zipcode.neighborhood.id
            @business.address2 = params[:business][:address2]
            @business.hear_about = params[:business][:hear_about]
            @business.contact_name = params[:business][:contact_name]
            @business.contact_number = [params[:business][:contact_number][:contact_area_code], params[:business][:contact_number][:contact_first_three_digits], params[:business][:contact_number][:contact_second_four_digits]].reject(&:blank?).join('.')
            @business.role = params[:business][:role]
            @business.save!
            FrugleMailer.new_merchant_registration(@business).deliver
            sign_in_and_redirect(:user, @user)  
          else
            render :action => 'edit'
          end
        else
          redirect_to new_business_path, :notice => "This email address is already in use."
        end
    end
    else
      @business = Business.find(params[:id])
      FrugleMailer.new_neighborhood_attempt(params[:business][:name], params[:business][:zip], params[:business][:email]).deliver
      @business.destroy
      flash[:notice] = "We're sorry, we are currently not offering our services in your neighborhood."
      redirect_to businesses_path, :notice => "We're sorry, we are currently not offering our services in your neighborhood."
    end
  end
  
  def couponmap
    @businesses = Business.find :all, :conditions => ["status = ?", "couponmap"]
    respond_to do |format|
        format.xml
    end
  end
  
  def add_to_couponmap
    @business = Business.find params[:business_id]
    @business.add_to_couponmap
    render :update do |page|
		  page.replace_html "couponmap_#{@business.id}", "Added"
	  end
  end

  def destroy
    @business = Business.find(params[:id])
    @business.destroy
    redirect_to businesses_url, :notice => "Successfully destroyed business."
  end
end
