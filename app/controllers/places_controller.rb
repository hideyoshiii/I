class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @places = Place.all.reverse_order
  end

  def show
    @place = Place.find(params[:id])
  end

  def new
    # 現在のユーザーのリスティングの作成
    @place = current_user.places.build
  end

  def create
    @place = current_user.places.build(place_params)

    if @place.save
      redirect_to user_path(current_user), notice: "リスティングを作成・保存をしました"
    else
      redirect_to new_place_path, notice: "リスティングを作成・保存出来ませんでした"
    end

  end

  def edit
     @place = Place.find(params[:id])
    if !(current_user == @place.user)
      redirect_to root_path, notice: "他人の編集ページにはアクセスできません"
    end
  end

  def update
    @place = Place.find(params[:id])
    if @place.update(place_params)
      redirect_to user_path(current_user), notice: "更新しました"
    end
  end

  private
  def place_params
    params.require(:place).permit(:title, :author, :description, :photo)
  end
end
