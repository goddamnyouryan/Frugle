class RepsController < ApplicationController
  def index
    if user_signed_in? && current_user.role == "rep"
      @zips = current_user.zipcodes.map(&:zip)
      @rep = Rep.new
      @reps = Array.new
      @zips.each do |zip|
        @results = Rep.find :all, :conditions => ["zip = ?", zip]
        @results.each do |result|
          @reps << result
        end
      end
      @frugle_options = [['Select a Frugle', "none"],
                         ['5% Off for New Customers', '5percentnew'], 
                         ['10% Off for New Customers', '10percentnew'], 
                         ['5% Off for Returning Customers', '5percentreturning'], 
                         ['10% Off for Returning Customers', '10percentreturning'],
                         ['5% Off for Anyone', '5percentanyone'], 
                         ['10% Off for Anyone', '10percentanyone'],
                         ['Manual Entry', 'manual']
                       ]
      render :layout => "frugle_view"
    else
      redirect_to root_path, :notice => "Sorry you must be a rep to come here."
    end
  end

  def create
  end

  def destroy
  end
  
  def show
  end
  
  def activate
    @rep = Rep.find params[:id]
    @business = Business.find_by_name_and_zip(@rep.name, @rep.zip)
    if @business == nil
      @business = Business.create(:name => @rep.name, :address => @rep.address, :zip => @rep.zip, :neighborhood_id => @rep.neighborhood_id, :phone => @rep.phone, :hear_about => "rep", :contact_name => params[:name])
    end
    @user = User.create(:email => params[:email], :password => "frugle", :password_confirmation => "frugle", :role => "business", :first_name => params[:name])
    if @user.save
      @business.user_id = @user.id
      @business.save
      @rep.update_attributes(:contacted => true, :status => "active", :contact_name => params[:name], :email => params[:email], :business_id => @business.id)
      FrugleMailer.rep_signup(@user.email, @user.first_name).deliver
      respond_to do |format|
    	  format.html { redirect_to rep_path }
    	  format.js
      end
    else
      redirect_to reps_path, :notice => "something went wrong"
    end
  end
  
  def save
    @rep = Rep.find params[:id]
    if @rep.status == "active"
      charset = %w{ 2 3 4 6 7 9 A C D E F G H J K L M N P Q R T V W X Y Z}
      @verification = (0...6).map{ charset.to_a[rand(charset.size)] }.join
      @subcategory = Subcategory.find_by_title(@rep.subcategory_name)
      @category = @subcategory.category
      if params[:frugle] == "none"
        @rep.update_attributes(:notes => params[:notes])
      elsif params[:frugle] == '5percentnew' 
        @frugle = Frugle.create(:business_id => @rep.business_id, :discount => "percent", :percentage => "5", :customers => "New", :product => "Purchase", :status => "active", :verification => @verification, :start => Time.now, :end => 4.months.from_now, :category_id => @category.id, :subcategory_id => @subcategory.id, :other_offer => true, :mobile => true, :altered => true, :views => 0 )
      elsif params[:frugle] == '10percentnew' 
        @frugle = Frugle.create(:business_id => @rep.business_id, :discount => "percent", :percentage => "10", :customers => "New", :product => "Purchase", :status => "active", :verification => @verification, :start => Time.now, :end => 4.months.from_now, :category_id => @category.id, :subcategory_id => @subcategory.id, :other_offer => true, :mobile => true, :altered => true, :views => 0 )
      elsif params[:frugle] == '5percentreturning'
        @frugle = Frugle.create(:business_id => @rep.business_id, :discount => "percent", :percentage => "5", :customers => "Returning", :product => "Purchase", :status => "active", :verification => @verification, :start => Time.now, :end => 4.months.from_now, :category_id => @category.id, :subcategory_id => @subcategory.id, :other_offer => true, :mobile => true, :altered => true, :views => 0 )
      elsif params[:frugle] == '10percentreturning'
        @frugle = Frugle.create(:business_id => @rep.business_id, :discount => "percent", :percentage => "10", :customers => "Returning", :product => "Purchase", :status => "active", :verification => @verification, :start => Time.now, :end => 4.months.from_now, :category_id => @category.id, :subcategory_id => @subcategory.id, :other_offer => true, :mobile => true, :altered => true, :views => 0 )
      elsif params[:frugle] == '5percentanyone'
        @frugle = Frugle.create(:business_id => @rep.business_id, :discount => "percent", :percentage => "5", :customers => "Anyone", :product => "Purchase", :status => "active", :verification => @verification, :start => Time.now, :end => 4.months.from_now, :category_id => @category.id, :subcategory_id => @subcategory.id, :other_offer => true, :mobile => true, :altered => true, :views => 0 )
      elsif params[:frugle] == '10percentanyone'
        @frugle = Frugle.create(:business_id => @rep.business_id, :discount => "percent", :percentage => "10", :customers => "Anyone", :product => "Purchase", :status => "active", :verification => @verification, :start => Time.now, :end => 4.months.from_now, :category_id => @category.id, :subcategory_id => @subcategory.id, :other_offer => true, :mobile => true, :altered => true, :views => 0 )
      elsif params[:frugle] == 'manual'
        
      end
    end
    respond_to do |format|
  	  format.html { redirect_to rep_path }
  	  format.js
    end
  end

end
