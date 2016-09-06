class LegalDaysController < ApplicationController
  before_action :set_legal_day, only: [:show, :edit, :update, :destroy]
  before_action :check_role

  # GET /legal_days
  # GET /legal_days.json
  def index
    @legal_days = LegalDay.all
  end

  # GET /legal_days/1
  # GET /legal_days/1.json
  def show
  end

  # GET /legal_days/new
  def new
    @legal_day = LegalDay.new
    @legal_day.year = Time::now.strftime("%Y").to_i
  end

  # GET /legal_days/1/edit
  def edit
    @legal_day.start_date = @legal_day.start_date.to_s(:short_date)
  end

  # POST /legal_days
  # POST /legal_days.json
  def create
    @legal_day = LegalDay.new(legal_day_params)
    if !legal_day_params[:start_date].nil? and legal_day_params[:start_date] != ''
      @legal_day.year = Time::parse(legal_day_params[:start_date]).strftime("%Y").to_i
    end

    respond_to do |format|
      if @legal_day.save
        format.html { redirect_to legal_days_url, notice: 'Legal day was successfully created.' }
        format.json { render :show, status: :created, location: @legal_day }
      else
        format.html { render :new }
        format.json { render json: @legal_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /legal_days/1
  # PATCH/PUT /legal_days/1.json
  def update
    respond_to do |format|
      if @legal_day.update(legal_day_params)
        format.html { redirect_to legal_days_url, notice: 'Legal day was successfully updated.' }
        format.json { render :show, status: :ok, location: @legal_day }
      else
        format.html { render :edit }
        format.json { render json: @legal_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /legal_days/1
  # DELETE /legal_days/1.json
  def destroy
    @legal_day.destroy
    respond_to do |format|
      format.html { redirect_to legal_days_url, notice: 'Legal day was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_legal_day
      @legal_day = LegalDay.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def legal_day_params
      params.require(:legal_day).permit(:year, :start_date, :name, :site_id)
    end
end
