class QuestionChannel < ApplicationCable::Channel
    def subscribed
        puts "SUBSCRIBED TO QUESTION"
        puts params
        # stream_from "some_channel"
        question = Question.find(params[:id])
        stream_for question
    end

    def unsubscribed
        puts "unsubscribed"
        # Any cleanup needed when channel is unsubscribed
    end
end