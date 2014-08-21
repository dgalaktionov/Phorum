class AddMessageToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :message, :text, {:null => false}
  end
end
