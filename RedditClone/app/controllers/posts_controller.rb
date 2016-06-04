class PostsController < ApplicationController

  def new
    @subs = Sub.all
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      @subs = Sub.all
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @subs = Sub.all
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(post_params)

    if @post.save
      redirect_to post_url(@post)
    else
      @subs = Sub.all
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @sub = Sub.find(@post.sub_id)
    @post.destroy
    redirect_to sub_url(@sub)
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, :author_id, :sub_ids => [])
  end

end
