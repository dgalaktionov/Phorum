module CategoriesHelper
  # How many posts does this category have?
  def count_posts(category)
    p = 0
    
    for topic in category.topics.all
      p += topic.posts.count
    end
    
    p
  end
  
  # Get the last edited topic for a category
  def get_last_edited_category_topic(category)
    category.topics.order(updated_at: :desc).first
  end
end
