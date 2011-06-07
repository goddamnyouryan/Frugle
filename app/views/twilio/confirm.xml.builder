xml.instruct!
xml.Response do
xml.Gather(:action => @postto, :numDigits => 1) do
    xml.Say "Hello this is a business verification call from Frugle."
    xml.Say "Your verification code is #{@business.verification}"
    xml.Say "Please press 1 to repeat this menu. Or press 3 if you are done."
    end
end