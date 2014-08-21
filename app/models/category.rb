class Category < ActiveRecord::Base
  has_many :topics
  validates :name, presence: true
  
  def to_s
    name
  end
end
