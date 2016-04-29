class Admin::UsersController < Admin::ApplicationController
  #当执行 show edit update destroy 之前先执行 set_user
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #当执行 edit update destroy 之前先执行 require_not_root
  before_action :require_not_root, only: [:edit, :update, :destroy]

def index
    @users = User.all
    if params[:q]
      @users = @users.where('email LIKE ?', "%#{params[:q]}%")
    end
    @users = @users.order(id: :desc).paginate page: params[:page], per_page: 30
  end

  def new
    @user = User.new
    @roles = Role.limit(100)
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
    
  end

  def edit
    @roles = Role.limit(100)
  end

  def update
    # role_ids = params[:roles_id]
    # if (role_ids)
    #   return 
    # end
    # @user.email = params[:email]
    # #roles = Role.where(id:role_ids)
    # #@user.roles = roles
    # #@user.roles.concat(roles)
    # @user.role_ids  = Role.where(id: params[:role_ids]).pluck(:id)
    # if @user.update_attributes(params[:user].permit! )
    #     redirect_to(admin_users_path, notice: 'User was successfully updated.')
    #   else
    #     redirect_to admin_users_path
    # end

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

  def set_user
    @user = User.find(params[:id])
  end

  def require_not_root
    if @user.root?
      redirect_to(admin_users_path, alert: 'You can not change admin user.')
    end
  end
end
