module CategoriesHelper
  # Returns a cache entry for a category
  def cache_key_for_category(id, updated)
    "category/#{id}-#{updated}"
  end
end
