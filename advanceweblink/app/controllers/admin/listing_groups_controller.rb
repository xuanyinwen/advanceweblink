class Admin::ListingGroupsController < ApplicationController
  layout "admin"  
  active_scaffold
  
  before_filter :require_admin_user
  
end