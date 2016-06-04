class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id

    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :author_id, :post_id, :parent_comment_id)
  end

end
