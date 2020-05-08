class Comment < ApplicationRecord
    belongs_to :question
    belongs_to :user
    has_many :comment_upvotes

    after_create :create_watch

    after_create :create_notification

    def create_watch
        Watch.find_or_create_by(user: self.user, question: self.question)
    end

    def create_notification
        # for every user except the current one
        # if the parameter is nil, use the one associated with this record
        user_to_exclude = self.user
        is_answered = false

        puts ""
        puts "create notification"
        puts "question: #{self.question.title}"
        puts "comment: #{self.text}"

        create_excluded_notification(user_to_exclude, is_answered)
    end

    def create_answer_notification(user_answer)
        user_to_exclude = user_answer
        is_answered = true

        create_excluded_notification(user_to_exclude, is_answered)
    end

    def create_excluded_notification(user_to_exclude, is_answered)
        self.question.watches.each do |watch|
            if watch.user != user_to_exclude then
                puts "new notification"
                puts "question: #{self.question.title}"
                puts "comment: #{self.text}"
                puts "user: #{watch.user.name}"
                puts "answered: #{is_answered}"
                # only create unique ones
                Notification.find_or_create_by(user: watch.user, question: watch.question, is_answered: is_answered)
            end
        end
    end
end
