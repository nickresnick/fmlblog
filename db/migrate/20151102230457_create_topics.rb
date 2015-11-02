class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.references :post, index: true
      t.references :user, index: true
      t.string :name

      t.timestamps null: false
    end
    add_foreign_key :topics, :posts
    add_foreign_key :topics, :users
  end
end
