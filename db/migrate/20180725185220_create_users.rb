class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :followers
      t.integer :folowing
      t.integer :number_of_posts
      t.float :engagement
      t.float :avg_engagement
      t.string :max_liked_post
      t.text :hastags
      t.boolean :is_winkl

      t.timestamps
    end
  end
end
