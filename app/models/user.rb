class User < ActiveRecord::Base
  acts_as_authentic

  image_accessor :image
   
  has_many :listing_groups
  has_many :properties, :through => :listing_groups
  
  has_many :listing_group_datas
  
  belongs_to :theme
  has_many :pages
  
  has_many :contacts
  
  before_create :default_values
  
  validates_uniqueness_of :guid

  # this protects from people trying to change other fields, like the admin field
  attr_accessible "name", "email", "password", "password_confirmation", "image", 
    "domain_name", "phone_work", "phone_after_hours", "phone_mobile", "phone_fax",
    "company", "tag_line"
  
  protected
  
    def default_values
      self.is_admin = false
      
      if RUBY_PLATFORM =~ /(win|w)32$/
        self.guid = Win32GUID.new_compact_guid
      else
        self.guid = UUID.new.generate.gsub('-', '')
      end
    end
      
end
