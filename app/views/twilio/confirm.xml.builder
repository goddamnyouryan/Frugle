xml.instruct!
xml.Response do
xml.Gather(:action => @postto, :numDigits => 1) do
    xml.Say "Hello this is a business verification call from Frugle."
    xml.Say "Your verification code is #{@business.verification.split("")[0]}. #{@business.verification.split("")[1]}. #{@business.verification.split("")[2]}. #{@business.verification.split("")[3]}."
    xml.Say "Once again thats. #{@business.verification.split("")[0]}. #{@business.verification.split("")[1]}. #{@business.verification.split("")[2]}. #{@business.verification.split("")[3]}. Thank you. Goodbye"
    end
end