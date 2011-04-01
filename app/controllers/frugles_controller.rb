class FruglesController < ApplicationController
  def index
    @frugles = Frugle.all
  end

  def show
    @frugle = Frugle.find(params[:id])
  end

  def new
    @frugle = Frugle.new
  end

  def create
    @frugle = current_user.business.frugles.new(params[:frugle])
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K L M N P Q R T V W X Y Z}
    @frugle.verification = (0...6).map{ charset.to_a[rand(charset.size)] }.join
    @frugle.status = "active"
    @frugle.views = 0
    @frugle.cost = params[:frugle][:cost]
    @frugle.discount = params[:frugle][:discount]
    if @frugle.save
      redirect_to root_path, :notice => "Successfully created frugle."
    else
      render :action => 'new'
    end
  end

  def edit
    @frugle = Frugle.find(params[:id])
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
