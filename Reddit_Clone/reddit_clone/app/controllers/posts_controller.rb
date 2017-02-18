class PostsController < ApplicationController
  before_action :logged_in?, only: [:edit, :update, :create, :new]
  before_action :check_poster?, only: [:edit, :update, :destroy]
  def new

    @post = Post.new

    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.sub_id = params[:sub_id]


    @post.author_id = current_user.id
    if @post.save
      redirect_to sub_url(@post.sub_id)
    else
       flash[:errors] = @post.errors.full_messages
       redirect_to sub_url(@post.sub_id)
     end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to sub_url(@post.sub_id)
    else
       flash[:errors] = @post.errors.full_messages
       redirect_to sub_url(@post.sub_id)
     end
  end

  def destroy
    @post = Post.find(params[:id])
    sub_id = @post.sub_id
    @post.destroy unless @post.nil?
    redirect_to sub_url(sub_id)
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id
    )
  end
end
