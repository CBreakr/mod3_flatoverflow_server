class User < ApplicationRecord
    has_many :questions
    has_many :comments
    has_many :question_upvotes
    has_many :comment_upvotes
    has_many :watches
    has_many :notifications

    has_many :active_follows, foreign_key: :follower_id, class_name: 'Follow'
    has_many :followees, through: :active_follows

    has_many :passive_follows, foreign_key: :followee_id, class_name: 'Follow'
    has_many :followers, through: :passive_follows

    def score

    end
    
end
