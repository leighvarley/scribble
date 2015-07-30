class CommentsController < ApplicationController

skip_before_action :authenticate_user!, only: [:new, :create]

  #index
  def index
    @comments = Comment.all.order(:id).reverse
  end

  #new
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  #create
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.create!(comment_params.merge(post: @post))
    redirect_to post_comment_path(@post, @comment)
  end

  #show
    def show
      @comment = Comment.find(params[:id])
    end

    #edit
    def edit
      @comment = Comment.find(params[:id])
    end

    #update
    def update
      @comment = Comment.find(params[:id])
      @post = Post.find(params[post: @post])
      @comment.update(post_params.merge(post: @post))
      redirect_to post_comment_path(@comment.post, @comment)
    end

    #destroy
    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      redirect_to comments_path
    end

    #private method to allow us to pull info from the form
    #require method ensure that a specific parameter is present
    #permit method returns a copy of the parameters object, returning only the permitted keys and values
    #encapsulate artist_params in a private method so that it will only be available to thie particular class so that it won't work outside the scope of the controller
    private
    def comment_params
      params.require(:comment).permit(:content)
    end

end #of class
