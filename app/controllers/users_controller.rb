class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_role, except: [:login, :logout, :signin]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.where(enabled: true).order(:firstname, :lastname)
  end

  # GET /users/1
  # GET /users/1.json
  def show
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
    @user = User.where('login = ?', user_params[:login]).first
    respond_to do |format|
      if !@user.nil? and @user.authenticate(user_params[:password]) != false
        flash[:notice] = "Hi #{@user.name}"
        session[:authentified] = true
        session[:last_updated_at] = Time::now
        session[:user_id] = @user.id
        format.html { redirect_to users_url }
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
    redirect_to login_path
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
                                   :site_id, :manager_id, :role)
    end
end
