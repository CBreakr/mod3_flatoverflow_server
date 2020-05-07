class CommentUpvotesController < ApplicationController
    def create
        puts "COMMENT UPVOTED"
        cu = CommentUpvote.new(comment_upvote_params)
        if cu.save then
            # I guess?
            render json: cu
        else
            # error
        end
    end

    private

    def comment_upvote_params
        params.require(:comment_upvote).permit(:comment_id, :user_id)
    end
end
