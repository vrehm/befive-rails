class RegistrationsController < Devise::RegistrationsController

  protected
  
  def after_update_path_for(current_user)
    pages_dashboard_path
  end
end
