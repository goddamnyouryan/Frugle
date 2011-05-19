#@businesses = Business.all
#@businesses.each do |business|
#  @subcategory = Subcategory.find_by_title(business.subcategory_name)
#  charset = %w{ 2 3 4 6 7 9 A C D E F G H J K L M N P Q R T V W X Y Z}
#  @verify = (0...6).map{ charset.to_a[rand(charset.size)] }.join
#  unless @subcategory.nil? 
#    @frugle = Frugle.create(:business_id => business.id, :discount => "percent", :details => "This Frugle has not been endorsed by the business owner.", :mobile => true, :verification => @verify, :status => "active", :cost => "10% Off Purchase", :percentage => "10", :product => "Purchase", :other_offer => true, :visit => true, :altered => true, :customers => "New", :category_id => @subcategory.category_id, :subcategory_id => @subcategory.id, :start =>"Wed, 18 May 2011", :end => "Thu, 18 Aug 2011", :views => 0)
#  else
#    @frugle = Frugle.create(:business_id => business.id, :discount => "percent", :details => "This Frugle has not been endorsed by the business owner.", :mobile => true, :verification => @verify, :status => "active", :cost => "10% Off Purchase", :percentage => "10", :product => "Purchase", :other_offer => true, :visit => true, :altered => true, :customers => "New", :category_id => 1, :subcategory_id => 1, :start =>"Wed, 18 May 2011", :end => "Thu, 18 Aug 2011", :views => 0)
#  end
#end

@frugles = Frugle.all
@frugle.each do |frugle|
  frugle.update_attributes(:views => 0)
end
