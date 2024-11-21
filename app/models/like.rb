class Like < ApplicationRecord
    belongs_to :user, class_name: "User"
    belongs_to :post, class_name: "Post"

    validates :user_id, uniqueness: { scope: :post_id, message: "can only like a post once" }
end
