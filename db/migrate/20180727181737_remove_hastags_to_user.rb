class RemoveHastagsToUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :hastags, :string
  end
end
