class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :followers
      t.string :following
      t.string :number_of_posts
      t.string :avg_engagement
      t.string :max_liked_post
      t.boolean :is_winkl

      t.timestamps
    end
  end
end
