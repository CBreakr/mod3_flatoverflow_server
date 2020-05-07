class Comment < ApplicationRecord
    belongs_to :question
    belongs_to :user
    has_many :comment_upvotes

    after_create :create_watch

    after_create :create_notification

    def create_watch
        Watch.find_or_create_by(user: self.user, question: self.question)
    end

    def create_notification(user_answer)
        # for every user except the current one
        # if the parameter is nil, use the one associated with this record
        user_to_exclude = self.user
        is_answered = false

        if user_answer then
            user_to_exclude = user_answer
            is_answered = true
        end

        self.question.watches.each do |watch|
            if watch.user != user_to_exclude then
                # only create unique ones
                Notification.find_or_create_by(user: watch.user, question: watch.question, is_answered: is_answered)
            end
        end
    end
end
