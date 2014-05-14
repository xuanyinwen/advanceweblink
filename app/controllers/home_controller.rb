class HomeController < ApplicationController

  def index
  
    # look for the user based on the domain name
    if @user = User.find_by_domain_name(request.host)
      load_page
      render :layout => 'themed'
    else
      redirect_to 'http://www.salespartner.co.nz'
    end
    
  end

end
