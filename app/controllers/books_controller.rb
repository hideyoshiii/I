class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @books = Book.all.reverse_order
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    # 現在のユーザーのリスティングの作成
    @book = current_user.books.build
  end

  def create
    @book = current_user.books.build(book_params)

    if @book.save
      redirect_to user_path(current_user), notice: "リスティングを作成・保存をしました"
    else
      redirect_to new_book_path, notice: "リスティングを作成・保存出来ませんでした"
    end

  end

  def edit
     @book = Book.find(params[:id])
    if !(current_user == @book.user)
      redirect_to root_path, notice: "他人の編集ページにはアクセスできません"
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to user_path(current_user), notice: "更新しました"
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :author, :description, :photo)
  end

end
