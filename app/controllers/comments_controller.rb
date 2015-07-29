class CommentsController < ApplicationController

  #index
  def index
    @comments = Comment.all.order(:id).reverse
  end

end
