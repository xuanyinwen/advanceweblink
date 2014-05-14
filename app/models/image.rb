class Image < ActiveRecord::Base
  image_accessor :image
  
  belongs_to :property
  
  named_scope :default, :conditions => {:default => true}
  
end
