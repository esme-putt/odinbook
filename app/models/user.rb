class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, class_name: "Post"
  has_many :comments, class_name: "Comment"

  # Follows a user is creating
  has_many :active_follows, 
    class_name: 'Follow', 
    foreign_key: 'follower_id', 
    dependent: :destroy

  # Follows a user is receiving
  has_many :passive_follows, 
    class_name: 'Follow', 
    foreign_key: 'followed_id', 
    dependent: :destroy

  # Users this user is following
  has_many :following, 
    through: :active_follows, 
    source: :followed

  # Users following this user
  has_many :followers, 
    through: :passive_follows, 
    source: :follower

  # Method to check if a user is following another user
  def following?(other_user)
    following.include?(other_user)
  end

  # Method to follow a user
  def follow(other_user)
    following << other_user unless self == other_user || following?(other_user)
  end

  # Method to unfollow a user
  def unfollow(other_user)
    following.delete(other_user)
  end
end
