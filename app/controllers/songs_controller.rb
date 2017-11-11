class SongsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @songs = Song.all.reverse_order
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    # 現在のユーザーのリスティングの作成
    @song = current_user.songs.build
  end

  def create
    @song = current_user.songs.build(song_params)

    if @song.save
      redirect_to user_path(current_user), notice: "リスティングを作成・保存をしました"
    else
      redirect_to new_song_path, notice: "リスティングを作成・保存出来ませんでした"
    end

  end

  def edit
     @song = Song.find(params[:id])
    if !(current_user == @song.user)
      redirect_to root_path, notice: "他人の編集ページにはアクセスできません"
    end
  end

  def update
    @song = Song.find(params[:id])
    if @song.update(song_params)
      redirect_to user_path(current_user), notice: "更新しました"
    end
  end

  private
  def song_params
    params.require(:song).permit(:title, :author, :description, :photo)
  end
end
