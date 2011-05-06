class FruglesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :verified, :show, :verify, :toggle, :about, :terms, :contact, :send_message]
  after_filter :increase_prints, :only => :print
  after_filter :increase_views, :only => :show
  after_filter :decrease_quantity, :only => :print
  
  def index
    @businesses = Business.find :all,
                  :conditions => ["LOWER(name) LIKE ?","%#{params[:search].to_s.downcase}%"]
                  
    @frugles = Frugle.find :all, 
               :include => [:category, :subcategory], 
               :conditions => ["LOWER(categories.title) LIKE ? OR LOWER(subcategories.title) LIKE ? OR LOWER(details) LIKE ? OR LOWER(cost) LIKE ?",
               "%#{params[:search].to_s.downcase}%", "%#{params[:search].to_s.downcase}%", "%#{params[:search].to_s.downcase}%", "%#{params[:search].to_s.downcase}%"]
    if @frugles.empty? || params[:search] == ""
      @frugles = Frugle.find :all, :joins => :business, :conditions => [ "businesses.neighborhood_id IS NOT NULL" ]
      @businesses = Business.find :all, :joins => :frugles, :conditions => ["frugles IS NOT NULL"]
    else
      @frugles = @frugles | Frugle.tagged_with(params[:search])
    end
  end

  def show
    @frugle = Frugle.find(params[:id])
    @business = @frugle.business
    if user_signed_in?
      @save = Saved.find_by_user_id_and_frugle_id(current_user.id, @frugle.id)
      unless current_user.role == "business"
        @follow = Follow.find_by_user_id_and_business_id(current_user.id, @business.id)
      end
    end
    render :layout => "frugle_view"
  end
  
  def send_message
    FrugleMailer.send_contact_message(params[:name], params[:email], params[:subject], params[:message]).deliver!
    redirect_to root_path, :notice => "Your message has been sent!"
  end
  
  def print
    @frugle = Frugle.find(params[:id])
    @business = @frugle.business
    @map = GMap.new("map_div")
    @map.control_init(:large_map => true,:map_type => true)
    @map.center_zoom_init([@business.latitude,@business.longitude],15)
    @map.overlay_init(GMarker.new([@business.latitude,@business.longitude],:title => "#{@business.name}", :info_window => "#{@business.name} <br /> #{@business.address}<br />#{@business.zip}<br />#{@business.phone}"))
    render :layout => "print"
  end

  def new
    @business = Business.find params[:business_id]
    if @business.frugles.count > 20
      redirect_to root_path
    else
      @frugle = Frugle.new
      @frugle_discount_options = [['% Off', 'percent'], ['$ Off', 'dollar'], ['$ For', 'flat'], ['Free with Purchase Of', 'bonus'], ['Buy One Get One Free', 'bogo']]
    end
  end
  
  def update_cost
  end

  def create
    @frugle = current_user.business.frugles.new(params[:frugle])
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K L M N P Q R T V W X Y Z}
    @frugle.verification = (0...6).map{ charset.to_a[rand(charset.size)] }.join
    @frugle.status = "active"
    @frugle.views = 0
    @frugle.category_id = @frugle.business.category_id
    @frugle.subcategory_id = @frugle.business.subcategory_id
    @frugle.discount = params[:frugle][:discount]
    if @frugle.discount == "percent"
      @frugle.cost = [params[:frugle][:percentage], params[:frugle][:product]].join(" % Off ")
    elsif @frugle.discount == "dollar"
      @frugle.cost = ["$#{params[:frugle][:percentage]}", params[:frugle][:product]].join(" Off ")
    elsif @frugle.discount == "flat"
      @frugle.cost = "$#{params[:frugle][:percentage]} For #{params[:frugle][:product]}"
    elsif @frugle.discount == "bonus"
      @frugle.cost = "Free #{params[:frugle][:percentage]} With Purchase Of #{params[:frugle][:product]}"
    elsif @frugle.discount == "bogo"
      @frugle.cost = "Buy One #{params[:frugle][:percentage]} Get One #{params[:frugle][:product]} Free"
    end
    @frugle.tag_list = params[:frugle][:tag_list]
    if @frugle.save
      redirect_to root_path, :notice => "Successfully created frugle."
    else
      flash[:notice] = "Please fill out the form completely."
      redirect_to :controller => "frugles", :action => 'new', :business_id => @frugle.business_id
    end
  end

  def edit
    @frugle = Frugle.find(params[:id])
    @frugle_discount_options = {'% Off' => 'percent', '$ Off' => 'dollar', '$ For' => 'flat', 'Free with Purchase Of' => 'bonus', 'Buy One Get One Free' => 'bogo' }
  end
  
  def verify
    render :layout => "splash"
  end
  
  def verified
    @frugle = Frugle.find_by_verification(params[:search].upcase)
    render :update do |page|
      if @frugle == nil
        page.replace_html "status", "This frugle doesn’t exist.  Either the code you entered is wrong, or the merchant canceled this frugle."
      else
        page.replace_html "status", "This frugle is #{@frugle.status}."
        page.replace_html "details", :partial => "neighborhoods/frugle", :locals => { :frugle => @frugle }
      end
    end
  end

  def update
    @frugle = Frugle.find(params[:id])
    if @frugle.update_attributes(params[:frugle])
      redirect_to root_path, :notice  => "Successfully updated frugle."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @frugle = Frugle.find(params[:id])
    @frugle.destroy
    redirect_to root_path, :notice => "Successfully destroyed frugle."
  end
  
  def toggle
    render :update do |page|
      page.visual_effect :toggle_blind, 'frugle_results'
      page.visual_effect :toggle_blind, 'frugles_show'
    end
  end
  
  private
  
  def increase_prints
    @frugle = Frugle.find(params[:id])
    @frugle.prints = @frugle.prints + 1
    @frugle.save
  end
  
  def increase_views
    @frugle = Frugle.find(params[:id])
    @frugle.views = @frugle.views + 1
    @frugle.save
  end
  
  def decrease_quantity
    @frugle = Frugle.find(params[:id])
    unless @frugle.quantity == nil
      @frugle.quantity = @frugle.quantity - 1
      if @frugle.quantity == 0 
        @frugle.status = "expired"
      end
      @frugle.save
    end
  end
  
end
