class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  validates :message, :user_id, :topic_id, presence: true
  
  def to_s
    message
  end
  
  def updated_time
    updated_at.to_time.strftime("%d-%m-%Y %H:%M:%S")
  end
end
