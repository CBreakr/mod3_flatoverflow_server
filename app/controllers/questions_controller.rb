class QuestionsController < ApplicationController
    before_action :get_question, only: [:show, :update]

    def index
        questions = Question.where(is_answered: nil)
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
        end
    end

    def myfilter
        puts "MY FILTER"
        puts params
        get_my_questions(params[:id])
    end

    def show
        # this should be tailored to include the comments/upvotes/tags/etc
        render json: @question, include: [:user, :question_upvotes, :tags, :reverse_comments => {:include => :comment_upvotes}]
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
        # order by datetime, only for today
        render json: Question.where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).order(created_at: :desc)
    end

    def get_new_questions
        # order questions by date, without an answers
        render json: Question.where(is_answered: nil).order(created_at: :desc)
    end

    def get_popular_questions
        # order questions by number of upvotes, without an answer
        render json: Question.where(is_answered: nil).sort_by {|q| q.question_upvotes.count }.reverse
    end

    def get_unanswered_questions
        # only get questions without comments
        questions = Question.all.filter do |q|
            q.comments.count == 0
        end
        render json: questions
    end

    def get_my_questions(id)
        # only get questions for this user
        render json: Question.where(user_id: id)
    end
end
