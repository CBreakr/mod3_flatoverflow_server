class QuestionsController < ApplicationController
    before_action :get_question, only: [:show, :update]

    def index
        questions = Question.all
        render json: questions, include: [:user, :question_upvotes, :tags, :comments => {:include => :comment_upvotes}]
    end

    def filter
        puts "FILTER"
        puts params
        case params[:filter_type]
        when "Today"
            get_today_questions
        when "New"
            get_new_questions
        when "Unanswered"
            get_unanswered_questions
        when "Popular"
            get_popular_questions
        when "Mine"
            # I need more input
            get_my_questions
        end
    end

    def show
        # this should be tailored to include the comments/upvotes/tags/etc
        render json: @question, include: [:user, :question_upvotes, :tags, :comments => {:include => :comment_upvotes}]
    end

    def create
        question = Question.create(question_params)
        if question.valid? then
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

    def get_today_questions

    end

    def get_new_questions

    end

    def get_popular_questions

    end

    def get_unanswered_questions

    end

    def get_my_questions

    end
end
