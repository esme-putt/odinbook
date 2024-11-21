class Post < ApplicationRecord
    belongs_to :user, class_name: "User"
    has_many :comments, class_name: "Comment"
    has_many :likes, class_name: "Like"

  # Method to check if a post is liked by a specific user
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
