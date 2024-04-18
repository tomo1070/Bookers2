class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      flash.now[:notice] = "投稿に失敗しました。"
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end
  
  def edit
    @book = Book.find(params[:id])
    @user = current_user
  end

  def show
    @user = current_user
    @books = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to book_path(@book)
  end

  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end
end
