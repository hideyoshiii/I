class GoodsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @goods = Good.all.reverse_order
  end

  def show
    @good = Good.find(params[:id])
  end

  def new
    # 現在のユーザーのリスティングの作成
    @good = current_user.goods.build
  end

  def create
    @good = current_user.goods.build(good_params)

    if @good.save
      redirect_to user_path(current_user), notice: "リスティングを作成・保存をしました"
    else
      redirect_to new_good_path, notice: "リスティングを作成・保存出来ませんでした"
    end

  end

  def edit
     @good = Good.find(params[:id])
    if !(current_user == @good.user)
      redirect_to root_path, notice: "他人の編集ページにはアクセスできません"
    end
  end

  def update
    @good = Good.find(params[:id])
    if @good.update(good_params)
      redirect_to user_path(current_user), notice: "更新しました"
    end
  end

  private
  def good_params
    params.require(:good).permit(:title, :description, :photo)
  end

end
