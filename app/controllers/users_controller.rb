class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :calendar]
  before_action :check_role, except: [:login, :logout, :signin, :show, :edit, :update, :calendar]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.where(enabled: true).order(:firstname, :lastname)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if @user.id != @session_user.id and !@session_user.hr?
      flash[:alert] = "You don't have access to this page"
      redirect_to user_path(@session_user) 
    end
    @leave_requests = @user.leave_requests.order(:start_date)
    if @session_user.manager?
      @team = Team.where("manager_id = ?", @session_user.id).first
      @team_leave_requests = []
      if !@team.nil?
        @team.users.where("id != ?", @session_user.id).each do |user|
          @team_leave_requests << user.leave_requests.where("status = ?", LeaveRequest::SUBMITTED).order(:start_date)
        end
        @team_leave_requests.flatten!
      end
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    # Force the login for admin account
    if @user.login == 'admin'
      user_params[:login] = 'admin'
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.enabled = false
    @user.save
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully disabled.' }
      format.json { head :no_content }
    end
  end

  # GET /users/login
  def login
    @user = User.new
  end

  # POST /users/signin
  def signin
    @user = User.where("enabled = 't' and login = ?", user_params[:login]).first
    respond_to do |format|
      if !@user.nil? and @user.authenticate(user_params[:password]) != false
        flash[:notice] = "#{t('welcome')} #{@user.name}"
        session[:authentified] = true
        session[:last_updated_at] = Time::now
        session[:user_id] = @user.id
        @session_user = @user
        format.html { redirect_to user_path(@user) }
      else
        @user = User.new
        flash[:alert] = "Login or Password incorrect"
        format.html { render :login }
      end
    end
  end

  # GET /users/logout
  def logout
    reset_session
    @session_user = nil
    redirect_to login_path
  end

  # GET /users/calendar
  def calendar
    @leave_requests = []
    @user.leave_requests.where("status != ?", LeaveRequest::REJECTED).order(:start_date).each do |leave_request|
      leave_request.dates.each do |date|
        @leave_requests << LeaveRequest::LeaveDate.new(date, leave_request.type_name, leave_request.status)
      end
    end
    LegalDay.order(:start_date).each do |date|
      @leave_requests << LeaveRequest::LeaveDate.new(date.start_date, 'BH', LeaveRequest::APPROVED)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:firstname, :lastname, :login, :password,
                                   :password_confirmation, :email, :external_id,
                                   :site_id, :team_id, :enabled, :role)
    end
end
