class UsersController < ApplicationController

  before_action :redirect_to_cats

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to cats_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end

  end

  def redirect_to_cats
    redirect_to cats_url if self.session_token == session[:session_token]
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
