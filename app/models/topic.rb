class Topic < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :posts
  validates :name, :message, :user_id, :category_id, presence: true
  
  def to_s
    name
  end
  
  # Links to last topics, etc...
  def stats_for_index
    
  end
  
  def updated_time
    updated_at.to_time.strftime("%d-%m-%Y %H:%M:%S")
  end
end
