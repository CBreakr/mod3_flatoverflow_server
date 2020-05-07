class TagsController < ApplicationController
    def index
        tags = Tag.all
        render json: tags
    end

    def create
        tag = Tag.create(tag_params)
        render json: tag
    end

    def trending
        tags = Tag.trending_tags
        render json: tags
    end

    private 

    def tag_params
        params.require(:tag).permit(:text)
    end
end
