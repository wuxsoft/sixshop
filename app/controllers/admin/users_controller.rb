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
    @olduser =  User.where("email = ?",params[:user][:email])
    if @olduser.count > 0
        redirect_to(new_admin_user_path, alert: 'Is Exist User email.')
        return
    end

    @user = User.new(params[:user].permit!)
    @user.email = params[:user][:email]
    @user.encrypted_password  = '88888888'
    @user.updated_at = Time.new
    @user.created_at = Time.new
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
    if(params[:id]==1)
      redirect_to admin_users_path
      return 
    end 
    role_ids = params[:roles_id]
    if (role_ids)
      return 
    end
    @olduser =  User.where("email = ? AND id <> ?", params[:email], params[:d])
    if @olduser.count > 0
        redirect_to(edit_admin_user_path, alert: 'Is Exist User email.')
        return
    end

    @user = User.find(params[:id])
    @user.email = params[:email]
    @user.updated_at = Time.new
    @roles = Role.where(id:role_ids)
    @user.roles = @roles
    if @user.update_attributes(params[:user].permit! )
        redirect_to(admin_users_path, notice: 'User was successfully updated.')
      else
        redirect_to admin_users_path
    end
  end

  def destroy
    if(params[:id]==1)
      redirect_to admin_users_path
      return 
    end
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to(admin_users_path, notice: 'User was successfully deleted.')
    else
      redirect_to(admin_users_path, alert: 'User was error deleted.')
    end

  end
end
