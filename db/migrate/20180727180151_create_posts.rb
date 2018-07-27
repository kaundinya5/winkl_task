class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :link
      t.integer :likes
      t.integer :engagement
      t.string :hashtags, array: true, default: []

      t.timestamps
    end
  end
end
