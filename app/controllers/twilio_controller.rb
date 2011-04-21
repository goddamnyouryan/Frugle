class TwilioController < ApplicationController
  
  # your Twilio authentication credentials
  ACCOUNT_SID = 'ACad8d4b4fdf2dbc4d131e6b8138df76a7'
  ACCOUNT_TOKEN = 'cefef731afed334a944b518bc2475726'

  # version of the Twilio REST API to use
  API_VERSION = '2010-04-01'

  # base URL of this application
  BASE_URL = "http://localhost:3000/twilio"

  # Outgoing Caller ID you have previously validated with Twilio
  CALLER_ID = '4242473970'

     # Use the Twilio REST API to initiate an outgoing call
     def makecall
         if !params['number']
             redirect_to({ :action => '.', 'msg' => 'Invalid phone number' })
             return
         end

         # parameters sent to Twilio REST API
         d = {
             'From' => CALLER_ID,
             'To' => params['number'],
             'Url' => BASE_URL + '/confirm',
         }
         begin
             account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
             resp = account.request(
                 "/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/Calls",
                 'POST', d)
             resp.error! unless resp.kind_of? Net::HTTPSuccess
         rescue StandardError => bang
             redirect_to({ :action => '.', 'msg' => "Error #{ bang }" })
             return
         end

         redirect_to({ :action => '', 
             'msg' => "Calling #{ params['number'] }..." })
     end
     
     def confirm
         @postto = BASE_URL + '/directions'

         respond_to do |format|
             format.xml { @postto }
         end
     end
  
  
end
