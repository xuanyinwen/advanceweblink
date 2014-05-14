class Page < ActiveRecord::Base
  belongs_to :user
  
  def to_params
    name
  end
  
end
