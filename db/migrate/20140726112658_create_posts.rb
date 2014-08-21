class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :message, null: false
      t.references :topic, null: false, index: true
      t.references :user, null: false, index: true

      t.timestamps
    end
  end
end
