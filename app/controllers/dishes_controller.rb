class DishesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @dishes = Dish.all.reverse_order
  end

  def show
    @dish = Dish.find(params[:id])
  end

  def new
    # 現在のユーザーのリスティングの作成
    @dish = current_user.dishes.build
  end

  def create
    @dish = current_user.dishes.build(dish_params)

    if @dish.save
      redirect_to user_path(current_user), notice: "リスティングを作成・保存をしました"
    else
      redirect_to new_dish_path, notice: "リスティングを作成・保存出来ませんでした"
    end

  end

  def edit
     @dish = Dish.find(params[:id])
    if !(current_user == @dish.user)
      redirect_to root_path, notice: "他人の編集ページにはアクセスできません"
    end
  end

  def update
    @dish = Dish.find(params[:id])
    if @dish.update(dish_params)
      redirect_to user_path(current_user), notice: "更新しました"
    end
  end

  private
  def dish_params
    params.require(:dish).permit(:title, :author, :description, :photo)
  end
end
