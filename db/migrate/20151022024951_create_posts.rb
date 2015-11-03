class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.string :title
      t.text :content
      t.references :user, index: true
      t.references :topic, index: true

      t.timestamps null: false
    end
    add_foreign_key :posts, :topics
    add_foreign_key :posts, :users

  end
end
