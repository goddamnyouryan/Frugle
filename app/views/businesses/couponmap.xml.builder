xml.instruct!
xml.tag!("localcoupons") do
  @businesses.each do |business|
    xml.store(:id => "#{business.id}") do
      xml.name "#{business.name}"
      xml.category "#{couponmap_category(business)}"
      xml.address1 "#{business.address}"
      xml.address2 "#{business.address2}"
      xml.city "Los Angeles"
      xml.state "CA"
      xml.zipcode "#{business.zip}"
      xml.phone "#{business.phone}"
      xml.latitude "#{business.latitude}"
      xml.longitude "#{business.longitude}"
      xml.hours
      xml.description "#{business.info}"
      xml.tag!("offers") do
        business.frugles.each do |frugle|
          xml.offer(:id => "#{frugle.id}") do
            xml.link "#{business_frugle_url(business, frugle)}"
            xml.description1 "#{frugle.cost}"
            xml.description2 "#{frugle.details} #{frugle_details(frugle)}"
            xml.endDate "#{l frugle.end.to_date, :format => :couponmap}"
          end
        end
      end
    end
  end
end