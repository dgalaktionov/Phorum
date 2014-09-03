class Category < ActiveRecord::Base
  has_many :topics
  #has_many :posts, through: :topics
  validates :name, presence: true
  
  def to_s
    name
  end
  
  # An optimized SQL query for the usual stuff
  def self.stats_for_index
    ActiveRecord::Base.connection.execute("SELECT c.id, c.name, count(distinct t.id), count(distinct p.id), c.updated_at, (SELECT id FROM topics WHERE category_id = c.id AND updated_at = max(t.updated_at) LIMIT 1), (SELECT name FROM topics WHERE updated_at = max(t.updated_at) LIMIT 1),  (SELECT id FROM posts WHERE topic_id = (SELECT id FROM topics WHERE updated_at = max(t.updated_at) LIMIT 1) ORDER BY updated_at DESC LIMIT 1) FROM (categories as c LEFT JOIN topics as t ON c.id = t.category_id) LEFT JOIN posts as p ON t.id = p.topic_id GROUP BY c.id")
  end
  
  # Links to last topics, etc...
  def topic_stats_for_index
    ActiveRecord::Base.connection.execute("SELECT t.id, t.category_id, t.name, count(distinct p.id), t.updated_at, (SELECT id FROM posts WHERE topic_id = t.id ORDER BY updated_at DESC LIMIT 1), (SELECT id FROM posts WHERE topic_id = t.id ORDER BY id DESC LIMIT 1) FROM topics AS t LEFT JOIN posts AS p ON t.id = p.topic_id GROUP BY t.id, t.category_id HAVING t.category_id = #{self.id} ORDER BY t.updated_at DESC")
  end
end
