module CategoriesHelper
  # Returns a cache entry for a category at index
  def cache_key_for_index(id, updated)
    "index/#{id}-#{updated}"
  end
  
  # Returns a cache entry for a topic at show for a given user
  def cache_key_for_show_user(topic, user)
    if user == nil
      "category/#{topic.id}-#{topic.updated_at}-GUEST"
    else
      "category/#{topic.id}-#{topic.updated_at}-#{user.id}-#{user.updated_at}"
    end
  end
end
