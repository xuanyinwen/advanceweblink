class Admin::ThemesController < ApplicationController
  layout "admin"  
  active_scaffold :theme do |config|
    list.columns.exclude :property_image, :property_line_item, :property_show, :content
#    config.actions = [:list, :nested]
  end
  
  before_filter :require_admin_user

end