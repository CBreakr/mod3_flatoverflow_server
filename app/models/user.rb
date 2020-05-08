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
        question_upvotes = self.questions.map do |q| 
            q.question_upvotes.length
        end.sum

        total_comment_upvotes = self.comments.map do |c| 
            c.comment_upvotes.length
        end.sum 

        verified_answers = self.comments.select do |c|
            c.is_answer == true
        end.length

        puts self.name
        puts question_upvotes
        puts total_comment_upvotes
        puts verified_answers

        return question_upvotes + total_comment_upvotes + verified_answers
        #@score = question_upvotes + total_comment_upvotes + verified_answers
    end
    
end
