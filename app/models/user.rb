class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, class_name: "Post"
  has_many :comments, class_name: "Comment"
  has_many :followers, class_name: "User"
  has_many :following, class_name: "User"
end
