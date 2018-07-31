class User < ApplicationRecord
  validates :name, presence: true
  validates :followers, presence: true
  # validates :following, presence: true
  # validates :number_of_posts, presence: true
end
