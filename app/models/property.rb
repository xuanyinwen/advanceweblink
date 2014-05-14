class Property < ActiveRecord::Base
  belongs_to :listing_group

  has_many :images,     :dependent => :destroy
  has_many :open_homes, :dependent => :destroy
  has_one  :agent,      :dependent => :destroy
  
  named_scope :old, lambda {|age| {:conditions => ['updated_at < ?', age.days.ago]  } }
  
  def update_attributes_from_xml!(listing)
      
    self.ref = listing.css('Ref').text
    
    self.listed_at                 = Time.parse listing.css('ListDate').text.gsub('/', '-')
    self.added_to_sales_partner_at = Time.parse listing.css('ListDate').text.gsub('/', '-')
    
    if address = listing.css('Address').first
      self.street_no = address.css('StreetNumber').text
      self.street    = address.css('Street').text
      self.suburb    = address.css('Suburb').text
      self.district  = address.css('District').text
      # TODO geo
    end
    
    self.hide_address = listing.css('HideAddressOnWeb').present?

    if advert = listing.css('Advert').first
      self.advert_heading        = advert.css('Heading').text
      self.advert_text           = advert.css('Text').text
      self.advert_selling_points = advert.css('SellingPoints').text
    end
    
    if price = listing.css('Price').first
      self.search_price  = price.css('SearchPrice').text.to_i
      self.display_price = price.css('DisplayPrice').text
    end
    
    self.category_code = listing.css('Category').attribute('Code').text if listing.css('Category').attribute('Code')
    self.category      = listing.css('Category').text
    
    self.status_code = listing.css('Status').attribute('Code').text if listing.css('Status').attribute('Code')
    self.status      = listing.css('Status').text
    
    self.listing_type = listing.css('ListingType').text

    self.bedrooms     = listing.css('Bedrooms').text.to_i
    self.rates        = listing.css('Rates').text
    self.garaging     = listing.css('Garaging').text.to_i
    self.bathrooms    = listing.css('Bathrooms').first.text.to_i #bathrooms can also feature in the features, so only get the first bathrooms node
    self.living_areas = listing.css('LivingAreas').text.to_i
    
    self.auction_at   = Time.parse listing.css('AuctionDate').text.gsub('/', '-')
    self.auction_details = listing.css('AuctionDatails').text

    self.tenure       = listing.css('Tenure').text.to_i
    
    if land_area = listing.css('LandArea').first
      self.land_area      = land_area.css('Area').text.to_i
      self.land_area_unit = land_area.css('AreaUnit').text
      self.land_area_sqm  = land_area.css('AreaSquareMeters').text.to_i
    end
    
    if floor_area = listing.css('FloorArea').first
      self.floor_area      = floor_area.css('Area').text.to_i
      self.floor_area_unit = floor_area.css('AreaUnit').text
      self.floor_area_sqm  = floor_area.css('AreaSquareMeters').text.to_i
    end
    
    self.gv = listing.css('GV').text.to_i
    self.lv = listing.css('LV').text.to_i

    if agent = listing.css('Agent1').first
      if !self.agent
        self.agent = Agent.create
      end
      self.agent.name = agent.css('Name').text
      self.agent.email = agent.css('Email').text
      self.agent.mobile = agent.css('Mobile').text
      self.agent.work = agent.css('Work').text
      self.agent.home = agent.css('Home').text
      self.agent.fax = agent.css('Fax').text
      self.agent.code = agent.css('Code').text
      self.agent.save
    end

    # open_homes = listing.css('OpenHomes')
    # if open_homes
    #   open_homes.each do |open_home|
    #   end
    # end
    
    save!
    
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
      
  end
  
end
