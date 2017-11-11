class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @movies = Movie.all.reverse_order
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    # 現在のユーザーのリスティングの作成
    @movie = current_user.movies.build
  end

  def create
    @movie = current_user.movies.build(movie_params)

    if @movie.save
      redirect_to user_path(current_user), notice: "リスティングを作成・保存をしました"
    else
      redirect_to new_movie_path, notice: "リスティングを作成・保存出来ませんでした"
    end

  end

  def edit
     @movie = Movie.find(params[:id])
    if !(current_user == @movie.user)
      redirect_to root_path, notice: "他人の編集ページにはアクセスできません"
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to user_path(current_user), notice: "更新しました"
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :author, :description, :photo)
  end
end
