# f = File.open("data/listings.xml")
# doc = Nokogiri::XML(f)
# f.close
# 
# listing = doc.xpath('//Listing')[0]
# listing.elements.collect &:name
# 
# listing.elements.css('LandArea').css('AreaUnit').text


class ListingGroupData < ActiveRecord::Base
  has_attached_file :data
  
  belongs_to :user
  
  def process_xml
    count = 0
    
    user.listing_groups.destroy_all
    
    file = File.open data.path
    doc = Nokogiri::XML file
    file.close
    
    group = user.listing_groups.create
    
    doc.xpath('//Listing').each do |listing|
      
      property = group.properties.create
      
      property.ref = listing.css('Ref').text
      
      property.listed_at                 = Time.parse listing.css('ListDate').text.gsub('/', '-')
      property.added_to_sales_partner_at = Time.parse listing.css('ListDate').text.gsub('/', '-')
      
      if address = listing.css('Address').first
        property.street_no = address.css('StreetNumber').text
        property.street    = address.css('Street').text
        property.suburb    = address.css('Suburb').text
        property.district  = address.css('District').text
        # TODO geo
      end
      
      property.hide_address = listing.css('HideAddressOnWeb').present?

      if advert = listing.css('Advert').first
        property.advert_heading        = advert.css('Heading').text
        property.advert_text           = advert.css('Text').text
        property.advert_selling_points = advert.css('SellingPoints').text
      end
      
      if price = listing.css('Price').first
        property.search_price  = price.css('SearchPrice').text.to_i
        property.display_price = price.css('DisplayPrice').text
      end
      
      property.category_code = listing.css('Category').attribute('Code').text if listing.css('Category').attribute('Code')
      property.category      = listing.css('Category').text
      
      property.status_code = listing.css('Status').attribute('Code').text if listing.css('Status').attribute('Code')
      property.status      = listing.css('Status').text
      
      property.listing_type = listing.css('ListingType').text

      property.bedrooms     = listing.css('Bedrooms').text.to_i
      property.rates        = listing.css('Rates').text
      property.garaging     = listing.css('Garaging').text.to_i
      property.bathrooms    = listing.css('Bathrooms').text.to_i
      property.living_areas = listing.css('LivingAreas').text.to_i
      
      property.auction_at   = Time.parse listing.css('AuctionDate').text.gsub('/', '-')
      property.auction_details = listing.css('AuctionDatails').text

      property.tenure       = listing.css('Tenure').text.to_i
      
      if land_area = listing.css('LandArea').first
        property.land_area      = land_area.css('Area').text.to_i
        property.land_area_unit = land_area.css('AreaUnit').text
        property.land_area_sqm  = land_area.css('AreaSquareMeters').text.to_i
      end
      
      if floor_area = listing.css('FloorArea').first
        property.floor_area      = floor_area.css('Area').text.to_i
        property.floor_area_unit = floor_area.css('AreaUnit').text
        property.floor_area_sqm  = floor_area.css('AreaSquareMeters').text.to_i
      end
      
      property.gv = listing.css('GV').text.to_i
      property.lv = listing.css('LV').text.to_i

      # open_homes = listing.css('OpenHomes')
      # if open_homes
      #   open_homes.each do |open_home|
      #   end
      # end
      
      property.save!
      
      # TODO tags not handled yet
      # 
      # REAXML
      #   reaxml_category
      #   reaxml_class
      # Agent
      # Features
      # OpenHomes - not correctly formatted - one open_home with many date and time entries
      # VendorPassword
      # CompanyFeatured
      # PhotoCount
      # URLS
      
      count += 1
    end
    
    count
  end
  
end
