class Admin::UsersController < ApplicationController
  layout "admin"  
  active_scaffold :user do |config|
    config.columns = [:email, :company, :domain_name]
  end
  
  before_filter :require_admin_user
  before_filter :load_user, :only => [:show, :edit, :update, :destroy]
  
  filter_parameter_logging :password, :password_confirmation
  
  def index
    @users = User.all
  end
  
  def show
  end
  
  def new
    @user = User.new
  end
  
  def create

    @user = User.new params[:user]
    if @user.save
      redirect_to admin_user_path(@user)
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    
    if @user.update_attributes(params[:user])
      
      redirect_to admin_user_path(@user)
    else
      render :action => :edit
    end
  end
  
  def destroy
    @user.destroy
    redirect_to :action => 'index'
  end
  
  protected
  
    def load_user
      @user = User.find params[:user_id] || params[:id]
    end
  
end