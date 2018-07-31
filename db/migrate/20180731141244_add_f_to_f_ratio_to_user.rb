class AddFToFRatioToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :f_to_f_ratio, :string
  end
end
