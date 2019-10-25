class Admin::UsersController < Admin::BaseController
  def edit
    @user = User.find(params[:user_id])

    if request.env['PATH_INFO'] == "/profile/#{@user.id}/edit/password"
      @password_change = true
    else
      @password_change = false
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
end
