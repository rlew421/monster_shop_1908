class UsersController < ApplicationController

  def new
  end

  def show
    render file: "/public/404" unless current_user
  end

  def create
    new_user = User.new(user_params)
    if new_user.save
      session[:user_id] = new_user.id
      redirect_to '/profile'
      flash[:sucess] = "You have registered successfully! You are now logged in as #{new_user.name}."
    else
      flash[:error] = new_user.errors.full_messages.to_sentence
      redirect_to '/register'
    end
  end

  private

  def user_params
    params.permit(:name, :city, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

end
