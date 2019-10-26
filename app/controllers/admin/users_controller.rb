class Admin::UsersController < Admin::BaseController
  def edit
    @user = User.find(params[:user_id])

    if request.env['PATH_INFO'] == "/admin/users/#{@user.id}/edit/password"
      @password_change = true
    else
      @password_change = false
    end
  end

  def update
    @user = User.find(params[:user_id])
    @user.update(user_params)

    if @user.save
      flash[:sucess] = "You have successfully updated #{@user.name}'s profile!" if request.env['REQUEST_METHOD'] == "PUT"
      flash[:sucess] = "You have successfully updated #{@user.name}'s password!" if request.env['REQUEST_METHOD'] == "PATCH"
      redirect_to "/admin/users"
    else
      flash[:error] = @user.errors.full_messages.to_sentence

      redirect_to "/admin/users/#{@user.id}/edit" if request.env['REQUEST_METHOD'] == "PUT"
      redirect_to "/admin/users/#{@user.id}/edit/password" if request.env['REQUEST_METHOD'] == "PATCH"
    end
  end

  def upgrade
    user = User.find(params[:user_id])
    if request.env['PATH_INFO'] == "/admin/users/#{user.id}/upgrade_merchant_employee"
      user.update_column(:role, "merchant_employee")
    else request.env['PATH_INFO'] == "/admin/users/#{user.id}/upgrade_merchant_admin"
      user.update_column(:role, "merchant_admin")
    end
    redirect_to '/admin/users'
  end

  private

  def user_params
    params.permit(:name, :city, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
end
