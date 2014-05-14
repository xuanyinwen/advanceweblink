class Import::PropertiesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :load_user_from_guid
  
  def api_index

    respond_to do |wants|
      wants.xml { render :xml => @user.properties }
    end

  end
  
  def api_show
    
    property = @user.properties.find_by_ref params[:id]

    respond_to do |wants|
      wants.xml { render :xml => property }
    end

  end
  
  def api_create_test
    @listing_group_data = @user.listing_group_datas.new
  end
  
  def api_create
    
    # create the first default listing group for the user if they don't have one already
    listing_group = @user.listing_groups.first || @user.listing_groups.create

    raw_xml = params[:data] || params[:listing_group_data]
    
    if raw_xml
      property = []
      
      extract_listings(raw_xml).each do |listing_xml|
      
        p = listing_group.properties.new params[:property]
        p.update_attributes_from_xml! listing_xml
      
        property << p
      end
      
    else
      property = listing_group.properties.create params[:property]
    end
    
    respond_to do |wants|
      wants.xml { render :xml => property }
    end
    
  end
  
  def api_update

    property = @user.properties.find_by_ref params[:id]
    property.update_attributes params[:property]
    property.update_attributes_from_xml! extract_listings(params[:data] || params[:listing_group_data]).first
    
    respond_to do |wants|
      wants.xml { render :xml => property }
    end
    
  end
  
  def api_destroy
    property = @user.properties.find_by_ref params[:id]
    property.destroy
    render :text => '', :status => 200
  end
  
  protected

    def extract_listings(params)
      # use this model to get at the xml data
      data = @user.listing_group_datas.create params
      file = File.open data.data.path
      doc = Nokogiri::XML file
      file.close
      data.destroy
      
      doc.xpath('//Listing')
    end
  
end