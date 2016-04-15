class Admin::ApplicationController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  layout 'admin'
  before_filter :authenticate_user!

  before_action :require_admin

  def require_admin
    if current_user.has_role? :admin
    else
      redirect_to :action => "index" , :controller=>"/home"
    end
  end

end
