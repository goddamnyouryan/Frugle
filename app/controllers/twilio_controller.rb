class TwilioController < ApplicationController
  protect_from_forgery :only => [:create, :update, :destroy] 
  
  require "twiliolib.rb"
  
  # your Twilio authentication credentials
  ACCOUNT_SID = 'ACad8d4b4fdf2dbc4d131e6b8138df76a7'
  ACCOUNT_TOKEN = 'cefef731afed334a944b518bc2475726'

  # version of the Twilio REST API to use
  API_VERSION = '2010-04-01'

  # base URL of this application
  BASE_URL = "http://www.frugle.me/twilio"

  # Outgoing Caller ID you have previously validated with Twilio
  CALLER_ID = '2136329639'

     # Use the Twilio REST API to initiate an outgoing call
  def makecall
    @business = Business.find_by_phone(params[:business_phone])
    # parameters sent to Twilio REST API
    d = {
      'From' => CALLER_ID,
      'To' => params[:business_phone],
      'Url' => BASE_URL + "/confirm.xml?business_id=#{@business.id}",
    }
    begin
      account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
      resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/Calls", 'POST', d)
      resp.error! unless resp.kind_of? Net::HTTPSuccess
    rescue StandardError => bang
      redirect_to({ :action => '.', 'msg' => "Error #{ bang }" })
      return
    end
    respond_to do |format|
      format.js
    end
  end
     
  def confirm
    @business = Business.find params[:business_id]
    @postto = BASE_URL + '/directions'
    respond_to do |format|
        format.xml { @postto }
    end
  end
     
  def directions
    if params['Digits'] == '3'
      redirect_to :action => 'goodbye'
      return
    end
    if !params['Digits'] or params['Digits'] != '2'
      redirect_to :action => 'reminder'
      return
    end
    @redirectto = BASE_URL + '/reminder',
    respond_to do |format|
      format.xml { @redirectto }
    end
  end
     
  def validate_verification
    @business = Business.find params[:business_id]
    respond_to do |format|
      format.json { render :json => @business.verification == "#{params[:business][:verify]}" }
    end
  end   
  
  
end
