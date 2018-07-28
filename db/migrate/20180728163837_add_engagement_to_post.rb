class AddEngagementToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :engagement, :string
  end
end
