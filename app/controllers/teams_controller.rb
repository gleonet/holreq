class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :calendar]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.includes(:manager).all.order(:name)
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /teams/calendar
  def calendar
    @leave_requests = []
    @team.users.includes(:leave_requests).order(:firstname).each do |user|
      user.leave_requests.where("status != ?", LeaveRequest::REJECTED).order(:start_date).each do |leave_request|
        leave_request.dates.each do |date|
          @leave_requests << LeaveRequest::LeaveDate.new(date, user.name, leave_request.status)
        end
      end
    end
    LegalDay.order(:start_date).each do |date|
      @leave_requests << LeaveRequest::LeaveDate.new(date.start_date, 'BH', LeaveRequest::APPROVED)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.includes(:manager).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:manager_id, :name, :external_id)
    end
end
