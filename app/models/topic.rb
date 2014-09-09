class Topic < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :posts
  validates :name, :message, :user_id, :category_id, presence: true
  validates :name, length: { maximum: 100 }
  validates :message, length: { maximum: 5000 }
  
  def to_s
    name
  end
  
  def updated_time
    updated_at.to_time.strftime("%d-%m-%Y %H:%M:%S")
  end
end
