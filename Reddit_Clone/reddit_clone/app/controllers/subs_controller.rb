class SubsController < ApplicationController
  before_action :check_owner?, only: [:edit, :update]
  before_action :logged_in?, only: [:edit, :update, :create, :new]

  def update
    @sub = Sub.find(params[:id])
    unless @sub.update_attributes(sub_params)
      flash[:errors] = @sub.errors.full_messages
      redirect_to "/subs/#{@sub.id}/edit"
    else
      redirect_to sub_url(@sub)
    end
  end

  def edit
    @sub = Sub.find_by_id(params[:id])
    render :edit
  end

  def create

    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id


    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def new
    @sub = Sub.new
    render :new
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
    render :show



    # can list posts
  end


  private

  def sub_params
    params.require(:subs).permit(:title, :description)
  end
end
