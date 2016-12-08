class Api::PostsController < ApplicationController
    skip_before_filter :verify_authenticity_token
    def index
        render json: Post.all
    end

    def show
        post = Post.find(params[:id])
        render json: post
    end

    def create
        post = Post.new(post_params)
        if post.save
            render json: {
                status: 200,
                message: "Successfully created post",
                post: post
                }.to_json
        else
            head 500
        end
    end

    private
    def post_params
        params.require(:post).permit(:title,:content)
    end
end
