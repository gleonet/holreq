class LeaveRequestsController < ApplicationController
  before_action :set_leave_request, only: [:show, :edit, :update, :destroy]

  # GET /leave_requests
  # GET /leave_requests.json
  def index
    @leave_requests = LeaveRequest.where("user_id = ?", params[:user_id] || @session_user.id).order(:start_date)
  end

  # GET /leave_requests/1
  # GET /leave_requests/1.json
  def show
  end

  # GET /leave_requests/new
  def new
    redirect_to user_path(@session_user) if params[:user_id].nil?
    @leave_request = LeaveRequest.new
    @leave_request.user_id = params[:user_id]
    @user = @leave_request.user
  end

  # GET /leave_requests/1/edit
  def edit
    @user = @leave_request.user
    if @leave_request.start_date < Time::now and !@session_user.hr?
      redirect_to user_path(@leave_request.user || @session_user, notice: 'You cannot edit a request in the past')
    end
  end

  # POST /leave_requests
  # POST /leave_requests.json
  def create
    @leave_request = LeaveRequest.new(leave_request_params)
    @user = @leave_request.user
    @leave = Leave.where("user_id = ? and leave_type_id = ?", leave_request_params[:user_id], leave_request_params[:leave_type_id]).first
    @leave_request.leave_id = @leave.id if !@leave.nil?

    if leave_request_params[:range] == 'single_date'
      @leave_request.end_date = @leave_request.start_date
    else
      @leave_request.period = nil
    end

    respond_to do |format|
      if @leave_request.save
        format.html { redirect_to @leave_request.user, notice: 'Leave request was successfully created.' }
        format.json { render :show, status: :created, location: @leave_request }
      else
        format.html { render :new }
        format.json { render json: @leave_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leave_requests/1
  # PATCH/PUT /leave_requests/1.json
  def update
    @leave = Leave.where("user_id = ? and leave_type_id = ?", leave_request_params[:user_id], leave_request_params[:leave_type_id]).first
    @leave_request.user_id = leave_request_params[:user_id]
    @leave_request.nb_hours = @leave_request.compute_nb_hours
    respond_to do |format|
      if @leave.nil? or @leave_request.nb_hours > @leave.available
        logger.warn("Leave is null") if @leave.nil?
        logger.warn("Not enough days") if !@leave.nil? and @leave_request.nb_hours > @leave.available
        format.html { render :edit, notice: 'Request is bigger than the available days.' }
        format.json { render json: @leave_request.errors, status: :unprocessable_entity }
      else
        @leave_request.status == LeaveRequest::SUBMITTED if @leave_request.status == LeaveRequest::APPROVED
        if @leave_request.update(leave_request_params)
          format.html { redirect_to @leave_request, notice: 'Leave request was successfully updated.' }
          format.json { render :show, status: :ok, location: @leave_request }
        else
          format.html { render :edit }
          format.json { render json: @leave_request.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /leave_requests/1
  # DELETE /leave_requests/1.json
  def destroy
    @user = @leave_request.user
    if @leave_request.start_date > Time::now or @session_user.hr?
      @leave_request.destroy
      notice = 'Leave request was successfully deleted.'
    else
      notice = 'Leave request cannot be deleted. Date are in the past'
    end

    respond_to do |format|
      format.html { redirect_to user_path(@user || @session_user), notice: notice }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_leave_request
    @leave_request = LeaveRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def leave_request_params
    params.require(:leave_request).permit(:user_id, :leave_id, :leave_type_id, :start_date, :end_date, :status, :approved_by_id, :nb_hours, :description, :range, :period)
  end
end
