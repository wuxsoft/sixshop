class Admin::UsersController < Admin::ApplicationController
def index
    @users = User.all
    if params[:q]
      @users = @users.where('email LIKE ?', "%#{params[:q]}%")
    end
    @users = @users.order(id: :desc).paginate page: params[:page], per_page: 30
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user].permit!)
    @user.email = params[:user][:email]
    @user.password = '88888888'
    @user.password_confirmation  = '88888888'
    if @user.save
      redirect_to(admin_users_path, notice: 'User was successfully created.')
    else
      render action: 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @roles = Role.limit(100)
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user].permit!)
      redirect_to(admin_users_path, notice: 'User was successfully updated.')
    else
      redirect_to admin_users_path
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      redirect_to(admin_users_path, notice: 'User was successfully deleted.')
    else
      redirect_to(admin_users_path, alert: 'User was error deleted.')
    end

  end
end
