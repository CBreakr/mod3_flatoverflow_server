class User < ApplicationRecord
    has_many :questions
    has_many :comments
    has_many :question_upvotes
    has_many :comment_upvotes
    has_many :watches
    has_many :notifications

    def score

    end
end
