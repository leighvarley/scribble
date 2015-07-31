class PostsController < ApplicationController

skip_before_action :authenticate_user!, only: [:index, :show]

  #Rails uses implicit rendering
  #In Rails we generally use redirect for request on forms

  #index
  def index
    @posts = Post.all.order(:id).reverse
  end

  #new
  def new
    @post = Post.new
  end

  #create
  def create
    @post = Post.create!(post_params)
    redirect_to post_path(@post)
     #if @post.save
       #redirect_to "/posts/#{@post.id}"
       #redirect_to @article
     #else
       #redirect_to "/posts/new"
       #render 'new'
     #end
  end

  #show
    def show
      @post = Post.find(params[:id])
      # @comments = @post.comments
    end

    #edit
    def edit
      @post = Post.find(params[:id])
    end

    #update
    def update
      @post = Post.find(params[:id])
      @post.update(post_params)
      redirect_to post_path(@post)
    end

    #destroy
    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to post_path
    end

    #Strong parameters - ActionController parameters cannot be used in Active Model mass assignments until they have been whitelisted.
    #Prevents accidental exposure of sensitive info
    #private method to allow us to pull info from the form require method ensure that a specific parameter is present
    #permit method returns a copy of the parameters object, returning only the permitted keys and values
    #encapsulate post_params in a private method so that it will only be available to thie particular class so that it won't work outside the scope of the controller
    #also helpful b/c can reuse the same permit list with create and update
     private
     def post_params
       params.require(:post).permit(:author, :title, :body)
     end

end
