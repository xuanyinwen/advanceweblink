class Import::ListingGroupDatasController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def new
    
    user = User.find_by_guid params[:guid]
    if user
      @listing_group_data = ListingGroupData.new
    else
      render_404
    end
    
  end
  
  def create
    user = User.find_by_guid params[:guid]
    if user
      
      data = user.listing_group_datas.create params[:listing_group_data]
      count = data.process_xml
      
      render :text => "#{count} properties added", :status => 200
    else
      render_404
    end
  end

end