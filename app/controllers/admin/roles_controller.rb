class Admin::RolesController < Admin::ApplicationController
  def index
    @roles = Role.all
    if params[:q]
      @roles = @roles.where('name LIKE ?', "%#{params[:q]}%")
    end
    @roles = @roles.order(id: :desc).paginate page: params[:page], per_page: 30
  end

  def new
    @role = Role.new
  end

  def create
    @oldRole =  Role.where("name = ?",params[:role][:name])
    if @oldRole.count > 0
        redirect_to(new_admin_role_path, alert: 'Is Exist Role Name.')
        return
    end

    @role = Role.new(params[:role].permit!)
    @role.name = params[:role][:name]
    @role.updated_at = Time.new
    @role.created_at = Time.new
    if @role.save
      redirect_to(admin_roles_path, notice: 'Role was successfully created.')
    else
      render action: 'new'
    end
  end

  def show
    @role = Role.find(params[:id])
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
    if(params[:id]==1)
      redirect_to admin_roles_path
      return 
    end 
    @oldRole =  Role.where("name = ? AND id <> ?", params[:name], params[:d])
    if @oldRole.count > 0
        redirect_to(edit_admin_role_path, alert: 'Is Exist Role Name.')
        return
    end

    @role = Role.find(params[:id])
    @role.name = params[:name]
    @role.updated_at = Time.new
    if @role.update_attributes(params[:role].permit!)
        redirect_to(admin_roles_path, notice: 'Role was successfully updated.')
      else
        redirect_to admin_roles_path
    end
  end

  def destroy
    if(params[:id]==1)
      redirect_to admin_roles_path
      return 
    end
    @role = Role.find(params[:id])
    if @role.destroy
      redirect_to(admin_roles_path, notice: 'Role was successfully deleted.')
    else
      redirect_to(admin_roles_path, alert: 'Role was error deleted.')
    end

  end

end
