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
            render status: 200, json: {
                message: "Successfully created post",
                post: post
                }.to_json
        else
            render status: 422, json: {
                errors: post.errors
                }.to_json
        end
    end

    def destroy
        post = Post.find(params[:id])
        post.destroy
        render status: 200, json: {
            message: "Deleted"
        }.to_json
    end

    def update
        post = Post.find(params[:id])
        if post.update(post_params)
            render status: 200, json: {
                message: "Successfully updated post",
                post: post
                }.to_json
        else
            render status: 500, json: {
                message: "Cannot update",
                post: post
                }.to_json
        end

    end

    private
    def post_params
        params.require(:post).permit(:title,:content)
    end
end
