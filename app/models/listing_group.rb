class ListingGroup < ActiveRecord::Base
  belongs_to :user
  has_many :properties, :dependent => :destroy
end
