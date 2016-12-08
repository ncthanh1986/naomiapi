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
            render json: {
                status: 500,
                errors: post.errors
                }.to_json
        end
    end

    def destroy
        post = Post.find(params[:id])
        post.destroy
        render json: {
            status: 200,
            message: "Deleted"
        }.to_json
    end

    private
    def post_params
        params.require(:post).permit(:title,:content)
    end
end
