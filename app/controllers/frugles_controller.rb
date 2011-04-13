class FruglesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :verified, :show]
  after_filter :increase_views, :only => :print
  
  def index
    if user_signed_in?
      @frugles = Business.find :all, 
                 :joins => [:category, :subcategory, :frugles], 
                 :conditions => ["LOWER(categories.title) LIKE ? OR LOWER(subcategories.title) LIKE ? OR LOWER(name) LIKE ? OR LOWER(frugles.cost) LIKE ? AND neighborhood_id = ?",
                 "%#{params[:search].to_s.downcase}%", "%#{params[:search].to_s.downcase}%", "%#{params[:search].to_s.downcase}%", "%#{params[:search].to_s.downcase}%", current_user.neighborhood_id]
      @frugles = @frugles | Frugle.tagged_with(params[:search])
    else
      @frugles = Business.find :all, 
                 :joins => [:category, :subcategory, :frugles], 
                 :conditions => ["LOWER(categories.title) LIKE ? OR LOWER(subcategories.title) LIKE ? OR LOWER(name) LIKE ? AND neighborhood_id = ?",
                 "%#{params[:search].to_s.downcase}%", "%#{params[:search].to_s.downcase}%", "%#{params[:search].to_s.downcase}%", params[:neighborhood]] 
      @frugles = @frugles | Frugle.tagged_with(params[:search])
    end       
  end

  def show
    @frugle = Frugle.find(params[:id])
    if user_signed_in?
      @save = Saved.find_by_user_id_and_frugle_id(current_user.id, @frugle.id)
    end
  end
  
  def print
    @frugle = Frugle.find(params[:id])
    render :layout => "print"
  end

  def new
    @frugle = Frugle.new
    @frugle_discount_options = [['% Off', 'percent'], ['$ Off', 'dollar'], ['$ For', 'flat'], ['Free with Purchase Of', 'bonus'], ['Buy One Get One Free', 'bogo']]
  end
  
  def update_cost
  end

  def create
    @frugle = current_user.business.frugles.new(params[:frugle])
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K L M N P Q R T V W X Y Z}
    @frugle.verification = (0...6).map{ charset.to_a[rand(charset.size)] }.join
    @frugle.status = "active"
    @frugle.views = 0
    @frugle.discount = params[:frugle][:discount]
    if @frugle.discount == "percent"
      @frugle.cost = [params[:frugle][:percentage], params[:frugle][:product]].join(" % Off ")
    elsif @frugle.discount == "dollar"
      @frugle.cost = ["$#{params[:frugle][:percentage]}", params[:frugle][:product]].join(" Off ")
    elsif @frugle.discount == "flat"
      @frugle.cost = "$#{params[:frugle][:percentage]} For #{params[:frugle][:product]}"
    elsif @frugle.discount == "bonus"
      @frugle.cost = "#{params[:frugle][:percentage]} With Purchase Of #{params[:frugle][:product]}"
    elsif @frugle.discount == "bogo"
      @frugle.cost = "Buy One #{params[:frugle][:percentage]} Get One #{params[:frugle][:product]} Free"
    end
    if @frugle.save
      redirect_to root_path, :notice => "Successfully created frugle."
    else
      render :action => 'new'
    end
  end

  def edit
    @frugle = Frugle.find(params[:id])
    @frugle_discount_options = {'% Off' => 'percent', '$ Off' => 'dollar', '$ For' => 'flat', 'Free with Purchase Of' => 'bonus', 'Buy One Get One Free' => 'bogo' }
  end
  
  def verified
    @frugle = Frugle.find_by_verification(params[:search])
    render :update do |page|
      if @frugle == nil
        page.replace_html "status", "This frugle doesn’t exist.  Either the code you entered is wrong, or the merchant canceled this frugle."
      else
        page.replace_html "status", "This frugle is #{@frugle.status}."
        page.replace_html "details","<h2>#{@frugle.business.name}<br />#{@frugle.cost}</h2>"
      end
    end
  end

  def update
    @frugle = Frugle.find(params[:id])
    if @frugle.update_attributes(params[:frugle])
      redirect_to @frugle, :notice  => "Successfully updated frugle."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @frugle = Frugle.find(params[:id])
    @frugle.destroy
    redirect_to root_path, :notice => "Successfully destroyed frugle."
  end
  
  private
  
  def increase_views
    @frugle = Frugle.find(params[:id])
    @frugle.views = @frugle.views + 1
    @frugle.save
  end
  
end
