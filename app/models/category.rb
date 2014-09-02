class Category < ActiveRecord::Base
  has_many :topics
  #has_many :posts, through: :topics
  validates :name, presence: true
  
  def to_s
    name
  end
  
  # An optimized SQL query for the usual stuff
  def self.stats_for_index
    ActiveRecord::Base.connection.execute("SELECT c.id, c.name, count(distinct t.id), count(distinct p.id), max(t.updated_at), (SELECT id FROM topics WHERE updated_at = max(t.updated_at) LIMIT 1), (SELECT name FROM topics WHERE updated_at = max(t.updated_at) LIMIT 1),  (SELECT id FROM posts WHERE topic_id = (SELECT id FROM topics WHERE updated_at = max(t.updated_at) LIMIT 1) AND updated_at = max(t.updated_at) LIMIT 1) FROM (categories as c LEFT JOIN topics as t ON c.id = t.category_id) LEFT JOIN posts as p ON t.id = p.topic_id GROUP BY c.id")
  end
end
