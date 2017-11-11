class UsersController < ApplicationController
  def show 
  	@user = User.find(params[:id]) #Userモデルから、userを探してきた。
  	@book = Book.find_by(user_id: @user.id)
  	@movie = Movie.find_by(user_id: @user.id)
  	@song = Song.find_by(user_id: @user.id)
  	@dish = Dish.find_by(user_id: @user.id)
  	@place = Place.find_by(user_id: @user.id)
  	@good = Good.find_by(user_id: @user.id)
  end
end
