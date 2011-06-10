class AssignmentsController < ApplicationController
  def create
    @zip = Zipcode.find params[:zip_id]
    @user = User.find_by_email(params[:email])
    unless @user.nil?
      @user.update_attributes(:role => "rep")
      @assignment = Assignment.create(:user_id => @user.id, :zipcode_id => @zip.id, :zip => @zip.zip)
      redirect_to @zip, :notice => "User assigned to this zip."
    else
      redirect_to @zip, :notice => "Sorry this user doesn't exist"
    end
  end

  def destroy
    @assignment = Assignment.find_by_user_id_and_zipcode_id(params[:user_id], params[:zipcode_id])
    @zip = Zipcode.find params[:zipcode_id]
    if @assignment.nil?
      redirect_to @zip, :notice => "Sorry something went wrong."
    else
      @assignment.destroy
      redirect_to @zip, :notice => "Assignment removed"
    end
  end

end
