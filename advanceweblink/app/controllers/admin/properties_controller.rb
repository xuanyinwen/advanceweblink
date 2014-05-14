class Admin::PropertiesController < ApplicationController
  layout "admin"  
  active_scaffold
  
  before_filter :require_admin_user
  
end