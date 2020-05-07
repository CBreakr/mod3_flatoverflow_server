class Tag < ApplicationRecord
    has_many :question_tags
    has_many :questions, through: :question_tags

    def self.trending_tags
        self.all.sort_by do |tag|
            tag.questions.length
        end.reverse.first(10)
    end
end
