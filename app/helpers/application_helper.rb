module ApplicationHelper
  def has_power_over?(thing)
    return user_signed_in? && (thing.user == current_user || current_user.user_type == 0 || current_user.user_type == 1)
  end
  
  def has_admin_power?
    user_signed_in? && current_user.user_type == 0
  end
  
  # Should not be used :-)
  def has_mod_power?
    user_signed_in? && (current_user.user_type == 0 || current_user.user_type == 1)
  end
  
  # All "back" buttons should call this
  def go_back
    if request.referer != nil
      redirect_to request.referer
    else
      redirect_to root_path
    end
  end

  # Check if the current user has power over a post or topic
  def check_power_over(thing)
    unless has_power_over?(thing)
      flash[:alert] = "You don't have permission over this!"
      
      go_back
    end
  end
  
  # Check if the current user is an admin
  def check_admin
    unless has_admin_power?
      flash[:alert] = "You don't have permission to do this!"
      
      go_back
    end
  end
  
  # When a user deletes its own account, this is called to edit all its topics and posts
  def kill_user(user)
    user.posts.each do |p| 
      p.message = "Deleted message"
      p.save!
    end
    user.topics.each do |t| 
      t.message = "Deleted message"
      t.save!
    end
    user.destroy
  end
  
  def ranks
   {0 => "Admin",
    1 => "Moderator",
    2 => "User"}
  end
  
  # Get the path to a post for paginate
  def get_post_path(post)
    [post.topic.category, post.topic, :page => post.topic.posts.where("id < :p", {p: post.id}).count/20 + 1, :anchor => post.id]
  end
  
  # Get the last post of a topic
  def get_last_post(topic)
    topic.posts.last
  end
  
  # Get a path to the last created post
  def get_last_post_path(topic)
    get_post_path(get_last_post(topic))
  end
  
  # Get a path to the last edited post of a topic
  def get_last_edited_post_path(topic)
    if topic.posts.empty?
      [topic.category, topic]
    else
      get_post_path(topic.posts.order(updated_at: :desc).first)
    end
  end
end