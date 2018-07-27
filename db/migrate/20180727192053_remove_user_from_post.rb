class RemoveUserFromPost < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :user, :string
  end
end
