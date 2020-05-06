class CommentsController < ApplicationController
    def create
        comment = Comment.new(comment_params)
        if comment.save then
            renderJSON(comment)
        else
            # error
        end
    end

    def mark_answer
        puts params
        comment = Comment.find(params[:id])
        if comment then
            comment.is_answer = true

            if comment.save then
                if comment.is_answer then
                    comment.question.is_answered = true

                    if comment.question.save then
                        # what to do here
                    else
                        # hmm... this is a weird error to hit
                    end
                end
                # I guess
                renderJSON(comment)
            else
                #error
            end
        else
            # what to do here?
        end
    end

    # def update
    #     comment = Comment.find(params[:id])
    #     if comment then
    #         comment.is_answer = comment_params[:is_answer]
    #         comment.save

    #         if comment.is_valid? then
    #             if comment.is_answer then
    #                 comment.question.is_answered = true
    #                 comment.question.save

    #                 if comment.question.is_valid? then
    #                     # what to do here
    #                 else
    #                     # hmm... this is a weird error to hit
    #                 end
    #             end
    #             # I guess
    #             render json: comment
    #         else
    #             #error
    #         end
    #     else
    #         # what to do here?
    #     end
    # end

    private

    def comment_params
        params.require(:comment).permit(:text, :question_id, :user_id)
    end

    def renderJSON(values)
        render json: values, include: [:user, :comment_upvotes]
    end
end
