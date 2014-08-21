class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name, null: false
      t.references :category, null: false, index: true
      t.references :user, null: false, index: true

      t.timestamps
    end
  end
end
