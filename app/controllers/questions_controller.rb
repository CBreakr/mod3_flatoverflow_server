class QuestionsController < ApplicationController
    before_action :get_question, only: [:show, :update]

    def index
        questions = Question.where(is_answered: nil).order(created_at: :desc)
        # render json: questions, include: [:user, :question_upvotes, :tags, :comments => {:include => :comment_upvotes}]
        renderJSON(questions)
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
        when "answered"
            get_answered_questions
        else
            get_questions_by_tag(params[:filter_type])
        end
    end

    def myfilter
        puts "MY FILTER"
        puts params
        get_my_questions(params[:id])
    end

    def show
        # this should be tailored to include the comments/upvotes/tags/etc
        # render json: @question, include: [:user, :question_upvotes, :tags, :reverse_comments => {:include => :comment_upvotes}]
        renderJSON(@question)
    end

    def create
        question = Question.new(question_params)
        if params["tags"] then
            params["tags"].each do |tag|
                newTag = nil
                if tag["id"] != "null" then
                    newTag = Tag.find(tag["id"])
                else
                    newTag = Tag.create(text: tag["text"])
                end

                question.tags << newTag
            end
        end

        if question.save then
            # render json: question
            renderJSON(question)
        else
            # error
        end
    end

    def update
        @question.update_note = params[:update_note]
        if @question.save then
            # render json: @question
            renderJSON(@question)
        else
            # error
        end
    end

    private

    def question_params
        params.require(:question).permit(:title, :text, :user_id)
    end

    def renderJSON(value)
        render json: value, include: [:user, :question_upvotes, :tags, :reverse_comments => {:include => [:comment_upvotes, :user]}]
    end

    #returns question tagged with a specific tag
    def get_questions_by_tag(tag)

        qt_list = QuestionTag.all.select { |qt|
            puts qt.tag
            qt.tag.text == tag
        }

        questions = qt_list.map { |qt| 
            qt.question
        }

        renderJSON(questions)
    end


    def get_question
        @question = Question.find(params[:id])
    end

    def get_today_questions
        # order by datetime, only for today
        # render json: Question.where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).order(created_at: :desc)
        renderJSON Question.where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).order(created_at: :desc)
    end

    def get_new_questions
        # order questions by date, without an answers
        # render json: Question.where(is_answered: nil).order(created_at: :desc)
        renderJSON Question.where(is_answered: nil).order(created_at: :desc)
    end

    def get_popular_questions
        # order questions by number of upvotes, without an answer
        # render json: Question.where(is_answered: nil).sort_by {|q| q.question_upvotes.count }.reverse
        renderJSON Question.where(is_answered: nil).sort_by {|q| q.question_upvotes.count }.reverse
    end

    def get_unanswered_questions
        # only get questions without comments
        questions = Question.all.filter do |q|
            q.comments.count == 0
        end
        # render json: questions
        renderJSON questions
    end

    def get_answered_questions
        renderJSON Question.where(is_answered: true).order(created_at: :desc)
    end

    def get_my_questions(id)
        # only get questions for this user
        # render json: Question.where(user_id: id).order(created_at: :desc)
        renderJSON Question.where(user_id: id).order(created_at: :desc)
    end
end
