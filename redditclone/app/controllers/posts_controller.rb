class PostsController < ApplicationController

    before_action :require_author, only [:edit, :update]

    def create
        @post = Post.new(post_params)

        if @post.save!
            redirect_to post_url(@post)
        else
            flash.now[:errors] = @post.errors.full_messages
            render :new
        end
    end

    def new
        @post = Post.new
        render :new
    end

    def edit
        @post = Post.find(params[:id])
        render :edit
    end

    def update
        @post = Post.find(params[:id])

        if @post.update_attributes(post_params)
            redirect_to post_url(@post)
        else
            flash.now[:errors] = @post.errors.full_messages
            render :edit
        end
    end

    def show
        @post = Post.find(params[:id])
        render :show
    end


    private

    def post_params
        params.require(:post).permit(:title, :url, :content, :sub_id, :author_id)
    end

    def require_author
        @post = Post.find(params[:id])
        redirect_to post_url(@post) if current_user.id != @post.author_id
    end
end