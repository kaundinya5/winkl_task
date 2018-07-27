class RemoveUsernameFromPost < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :username, :string
  end
end
