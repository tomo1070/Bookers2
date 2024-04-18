class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create]

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = current_user
    @user = User.find(params[:id])
  end

  def edit
    user = User.find(params[:id])
      if user_params.present?
        user.update(user_params)
      else
        render :edit
      end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
  end
end
