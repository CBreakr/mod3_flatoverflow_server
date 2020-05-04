class QuestionsController < ApplicationController
    before_action :get_question, only: [:show, :update]

    def index
        questions = Question.all
        render json: questions
    end

    def show
        # this should be tailored to include the comments/upvotes/tags/etc
        render json: @question, include: [:question_upvotes, :tags, :comments => {:include => :comment_upvotes}]
    end

    def create
        byebug
        question = Question.create(question_params)
        if question.valid then
            render json: question
        else
            # error
        end
    end

    def update
        @question.update_note = question_params[:update_note]
        if @question.save then
            render json: @question
        else
            # error
        end
    end

    private

    def question_params
        params.require(:question).permit(:title, :text, :update_note, :user_id)
    end

    def get_question
        @question = Question.find(params[:id])
    end
end
