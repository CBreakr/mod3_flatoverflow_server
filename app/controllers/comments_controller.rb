class CommentsController < ApplicationController
    def create
        comment = Comment.new(comment_params)
        if comment.save then
            question = Question.find(comment.question_id)
            QuestionChannel.broadcast_to(question, {type: "new", id: comment.id, text: comment.text, user: comment.user, comment_upvotes: comment.comment_upvotes})
            # QuestionChannel.broadcast_to(question, comment.to_json(include: [:user, :comment_upvotes]))
            # renderJSON(comment)
        else
            # error
        end
    end

    def upvotes 
        # byebug
        user_id = params[:user_id].to_i
        user = User.find_by(id: user_id)

        comments = user.comments

        verified_answers = comments.select do |c|
            c.is_answer == true
        end

        total_comment_upvotes = comments.map do |c| 
            c.comment_upvotes.length
        end.sum 

        total_points = total_comment_upvotes + verified_answers.length

        render json: total_points
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
                        # create the notification
                        puts "ANSWERED, NOW FOR NOTIFICATION"
                        comment.create_answer_notification(comment.question.user)
                    else
                        # hmm... this is a weird error to hit
                    end
                end
                # I guess
                # renderJSON(comment)
                question = Question.find(comment.question_id)
                QuestionChannel.broadcast_to(question, {type: "answer", id: comment.id, text: comment.text, user: comment.user, comment_upvotes: comment.comment_upvotes})
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
