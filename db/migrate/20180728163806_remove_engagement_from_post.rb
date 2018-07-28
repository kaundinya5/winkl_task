class RemoveEngagementFromPost < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :engagement, :string
  end
end
