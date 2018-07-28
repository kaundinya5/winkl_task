class Post < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :link, presence: true
  validates :likes, presence: true
end
