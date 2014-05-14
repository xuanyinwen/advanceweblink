class ImagesController < ApplicationController
  
  before_filter :load_data
  
  def show
    @image = @property.images.find params[:id]
    render :layout => 'themed'
  end
  
  protected
    
    def load_data
      @user = User.find params[:user_id]
      @property = @user.properties.find params[:property_id]
    end

end