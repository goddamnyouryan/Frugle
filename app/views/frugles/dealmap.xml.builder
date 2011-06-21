xml.instruct!
xml.tag!("AddDealRequest",
    'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance",
    'xmlns:xsd' => "http://www.w3.org/2001/XMLSchema") do
  xml.ID "#{@frugle.id}"
  xml.Title "#{@frugle.cost}"
  xml.Details "#{@frugle.details}"
  xml.Restrictions "#{@frugle.customers}"
  xml.EffectiveDate "#{@frugle.start}"
  xml.ExpirationDate "#{@frugle.end}"
  xml.Url "#{business_frugle_url(@frugle.business, @frugle)}"
  xml.IsExclusive "false"
  xml.FirstName ""
  xml.LastName ""
  xml.IsOwner "false"
  xml.AddedBy "Taylor Ballenger"
  xml.SocialNetworkID ""  
  xml.DailyDealsEmailOK "false"
  xml.StreetAddress "#{@frugle.business.address}"
  xml.City "Los Angeles"
  xml.State "CA"
  xml.Country "United States"
  xml.Latitude "#{@frugle.business.latitude}"
  xml.Longitude "#{@frugle.business.longitude}"
  xml.BusinessName "#{@frugle.business.name}"
  xml.BusinessDetails "#{@frugle.business.info}"
  xml.PhotoType  
  xml.PhotoContent  
  xml.Tags "#{@frugle.tag_list}"
  xml.Category "#{@frugle.subcategory.title}"
  xml.Styles
  xml.VendorId  
  xml.DealSource
  xml.Affiliation  
  xml.PostalCode "#{@frugle.business.zip}" 
end