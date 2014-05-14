class Import::ImagesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :load_user_from_guid, :load_property
  
  def api_index

    respond_to do |wants|
      wants.xml { render :xml => @property.images }
    end

  end

  def api_show
    
    @image = @property.images.find_by_position params[:id]

    respond_to do |wants|
      wants.xml { render :xml => @image }
      wants.html
    end

  end
  
  def api_create
    
    # doing this as when the salespartner delphi app puts the image in image[image] var it doesn't appear
    params[:image][:image] = params[:image_data]
    
    image = @property.images.create params[:image]
    
    respond_to do |wants|
      wants.xml { render :xml => image }
    end
    
  end
  
  def api_create_test
    @image = @property.images.new
  end
  
  def api_update

    image = @property.images.find_by_position params[:id]
    image.update_attributes params[:image]
    
    respond_to do |wants|
      wants.xml { render :xml => image }
    end
    
  end
  
  def api_destroy
    image = @property.images.find_position params[:id]
    image.destroy
    render text '', :status => 200
  end
  
  protected
  
    def load_property
      @property = @user.properties.find_by_ref params[:property_id]
    end
  
end
