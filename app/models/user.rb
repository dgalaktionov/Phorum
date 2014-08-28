class User < ActiveRecord::Base
  has_many :topics
  has_many :posts
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :email
  validates_uniqueness_of :email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable
         
  # Virtual attribute for authenticating by username
    def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    
    if name = conditions.delete(:name)
      where(conditions).where(["lower(name) = :value", { :value => name.downcase }]).first
    else
      where(conditions).first
    end
  end
  
  def to_s
    "<a href=\"/users/#{self.id}\">#{self.name}</a>".html_safe
  end
  
  def delete_stuff?
  end
  
  def delete_stuff=(stub)
  end
  
  def created_time
    created_at.to_time.strftime("%d-%m-%Y %H:%M:%S")
  end
  
  def last_login_time
    current_sign_in_at.to_time.strftime("%d-%m-%Y %H:%M:%S")
  end
end
