class UsersController < ApplicationController
  def show 
  	@user = User.find(params[:id]) #Userモデルから、userを探してきた。
  	@book = Book.find_by(user_id: current_user.id)
  	@movie = Movie.find_by(user_id: current_user.id)
  	@song = Song.find_by(user_id: current_user.id)
  	@dish = Dish.find_by(user_id: current_user.id)
  	@place = Place.find_by(user_id: current_user.id)
  	@good = Good.find_by(user_id: current_user.id)
  end
end
