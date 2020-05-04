class UsersController < ApplicationController
  before_action :correct_user?, only: [:edit, :update]
  
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    @user_own = current_user
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    
    if @user.save
      redirect_to user_path(@user.id)
      flash[:notice] = "You have updated user successfully."
    else
      render :edit
    end
  end

  private 
  def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user?
    @user = current_user.id
    @access_id = params[:id].to_i
      unless @user == @access_id
        redirect_to books_path
      end
  end
end
