class FruglesController < ApplicationController
  def index
    if user_signed_in?
      @frugles = Business.find :all, 
                 :joins => [:category, :subcategory], 
                 :conditions => ["categories.title LIKE ? OR subcategories.title LIKE ? OR name LIKE ? AND neighborhood_id = ?",
                 "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", current_user.neighborhood_id]
    else
      @frugles = Business.find :all, 
                 :joins => [:category, :subcategory], 
                 :conditions => ["categories.title LIKE ? OR subcategories.title LIKE ? OR name LIKE ? AND neighborhood_id = ?",
                 "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", params[:neighborhood]]
    end       
  end

  def show
    @frugle = Frugle.find(params[:id])
    @save = Saved.find_by_user_id_and_frugle_id(current_user.id, @frugle.id)
  end

  def new
    @frugle = Frugle.new
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
  end
  
  def verified
    @frugle = Frugle.find_by_verification(params[:search])
    render :update do |page|
      if @frugle == nil
        page.replace_html "status", "This frugle doesn't exist."
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
end
