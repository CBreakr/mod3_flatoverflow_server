class QuestionUpvotesController < ApplicationController
    def create
        qu = QuestionUpvote.create(question_upvote_params)
        if qu.is_valid? then
            # I guess?
            render json: qu
        else
            #error
        end
    end

    private

    def question_upvote_params
        params.require(:question_upvote).permit(:question_id, :user_id)
    end
end
