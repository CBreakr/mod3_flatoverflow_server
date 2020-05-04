class Comment < ApplicationRecord
    belongs_to :question
    belongs_to :user
    has_many :comment_upvotes
end
