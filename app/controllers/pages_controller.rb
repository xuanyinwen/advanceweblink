class PagesController < ApplicationController
  uses_tiny_mce :only => [:edit, :update], 
    :options => {
      :theme => 'advanced',
      :browsers => %w{msie gecko},
      :theme_advanced_toolbar_location => "top",
      :theme_advanced_toolbar_align => "left",
      :theme_advanced_resizing => true,
      :theme_advanced_resize_horizontal => false,
      :plugins => %w{ table },
      :theme_advanced_buttons1 => %w{formatselect fontselect fontsizeselect bold italic underline strikethrough separator justifyleft justifycenter justifyright justifyfull indent outdent separator bullist numlist forecolor backcolor separator link unlink image undo redo},
      :theme_advanced_buttons2 => %w{hr code removeformat sub sup charmap visualaid separator tablecontrols},
      :theme_advanced_buttons3 => []
    }
  
  before_filter :require_user, :except => [:show]
  before_filter :load_user
  before_filter :load_page
  
  def show
    render :layout => 'themed'
  end
  
  def new
    @uses_tiny_mce = true
    @page = current_user.pages.new :name => params[:name], :data => 'under construction'
  end
  
  def create
    @page = current_user.pages.new params[:page]
    if @page.save
      redirect_to user_page_path(current_user, :id => @page.name)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @uses_tiny_mce = true
  end
  
  def update
    
    if @page.update_attributes(params[:page])
      redirect_to user_page_path(current_user, :id => @page.name)
    end
    
  end
  

end