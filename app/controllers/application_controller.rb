class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :check_auth, except: [:login, :logout, :signin]

  # Check if user has signed in
  def check_auth
    if !session[:authentified] or session[:last_updated_at] < 3.hours.ago
      redirect_to login_path
    else
      session[:last_updated_at] = Time::now
      @session_user = User.find(session[:user_id])
    end
  end

  def check_role
    if !@session_user.admin? and !@session_user.hr?
      flash[:alert] = "You don't have the permission to access this section"
      redirect_to '/'
    end
  end

end
