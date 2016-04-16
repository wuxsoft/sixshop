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
end
