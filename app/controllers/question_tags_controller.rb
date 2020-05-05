class QuestionTagsController < ApplicationController
  def index 
    question_tag = QuestionTag.all
    render json: question_tag
  end

  def create
    # byebug
    question_tag = QuestionTag.create(question_tag_params)
    render json: question_tag
  end

  private 

  def question_tag_params
    params.require(:question_tag).permit(:tag_id, :question_id)
  end
end
