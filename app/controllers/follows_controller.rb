class FollowsController < ApplicationController
  def index
    follows = Follow.all 
    render json: follows, include: [:follower, :followee]
  end

  def create
    # byebug
    if (follow_params[:follower_id].to_i != follow_params[:followee_id].to_i)
      follow = Follow.find_or_create_by(follower_id: follow_params[:follower_id],   followee_id: follow_params[:followee_id])
      render json: follow, include: [:follower, :followee]
    end
  end

  def filter
    # byebug
    followees = Follow.all.select do |follow| 
      follow.follower_id == (params[:current_user]).to_i
    end
    render json: followees, include: [:follower, :followee]
  end

  private

  def follow_params
    params.require(:follow).permit(:follower_id, :followee_id)
  end
end
