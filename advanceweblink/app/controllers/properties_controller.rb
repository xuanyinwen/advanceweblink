class PropertiesController < ApplicationController
  
  before_filter :load_user
  
  def index
    @properties = @user.properties.find(:all, :order => 'updated_at')
      #order by when it was modified so it prints in the same order it was uploaded (approximately as resolution is only 1 second for a timestamp)
    render :layout => 'themed'
  end
  
  def show
    @property = @user.properties.find params[:id]
    render :layout => 'themed'
  end
  
  protected
    
    def load_user
      @user = User.find params[:user_id]
    end

end