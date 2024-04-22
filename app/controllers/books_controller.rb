class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      flash.now[:notice]
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
    if @book.user_id != current_user.id
      redirect_to books_path
    end
    @user = current_user
  end
  
  def update
    @book = Book.find(params[:id])
    if book_params[:title].blank?
      flash.now[:alert]
      render :edit
    elsif @book.update(book_params)
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      flash.now[:notice]
      render :edit
    end
  end

  def show
    @books = Book.find(params[:id])
    @user = @books.user
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end
end
