class User < ActiveRecord::Base
  has_many :topics
  has_many :posts

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
    name
  end
  
  def delete_stuff?
  end
  
  def delete_stuff=(stub)
  end
end
