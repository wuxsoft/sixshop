class Admin::RoleController < Admin::ApplicationController
  def index
    @roles = Role.all
    if params[:q]
      @roles = @roles.where('name LIKE ?', "%#{params[:q]}%")
    end
    @roles = @roles.order(id: :desc).paginate page: params[:page], per_page: 30
  end


  def new
  end

  def show
  end

  def edit
    @role = Role.find(params[:id])
  end


  def update
    if(params[:id]==1)
      redirect_to :action => "index" , :controller=>"admin/role"
      return 
    end
    @role = Role.find(params[:id])
    @role.name = params[:name]
    @role.updated_at = Time.new
    if @role.update_attributes(params[:role].permit!)
        redirect_to(edit_admin_role_path(@role.id), notice: 'Role was successfully updated.')
      else
        redirect_to :action => "index" , :controller=>"admin/role"
    end
  end


end
