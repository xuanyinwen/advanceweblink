# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user

  private
  
    def render_404
      respond_to do |type|
        type.html { render :file => "#{Rails.root}/public/404.html", :status => "404 Not Found" }
        type.all  { render :nothing => true, :status => "404 Not Found" }
      end
    end
  
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end
    
    def require_admin_user
      unless current_user && current_user.is_admin
        render_404
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    def load_user_from_guid
     @user = User.find_by_guid params[:guid]
    end
    
    def load_user
      @user = User.find params[:user_id]
    end
    
    def load_page
      params[:id] ||= 'index'
      @page = @user.pages.find_by_name(params[:id]) || @user.pages.new(:name => params[:id], :data => 'under construction')
    end
    
end
