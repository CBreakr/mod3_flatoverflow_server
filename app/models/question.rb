class Question < ApplicationRecord
    belongs_to :user
    has_many :comments
    has_many :question_upvotes
    has_many :question_tags
    has_many :tags, through: :question_tags

    def reverse_comments
        self.comments.sort_by{|c| c.created_at}.reverse
    end
end
