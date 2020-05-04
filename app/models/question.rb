class Question < ApplicationRecord
    belongs_to :user
    has_many :comments
    has_many :question_upvotes
    has_many :question_tags
    has_many :tags, through: :question_tags
end
