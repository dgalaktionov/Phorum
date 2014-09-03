module TopicsHelper
  # Generate a cache key for the topics of a user
  def cache_key_for_user_topics(user, topics, page)
    if current_user == nil
      "user/#{user.id}-#{user.updated_at}/topics/#{page}-#{topics.maximum(:updated_at)}/GUEST"
    else
      "user/#{user.id}-#{user.updated_at}/topics/#{page}-#{topics.maximum(:updated_at)}/#{current_user.id}-#{current_user.updated_at}"
    end
  end
end
