class AddUpdatedTimeIndexes < ActiveRecord::Migration
  def change
    add_index :topics, :updated_at,                unique: false
    add_index :posts, :updated_at,                unique: false
  end
end
