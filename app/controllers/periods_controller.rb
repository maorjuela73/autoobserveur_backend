class PeriodsController < ApplicationController
  before_action :set_period, only: [:show, :update, :destroy, :switch_updated]
  before_action :get_active_period
  before_action :authenticate_user
  # GET /periods
  def index
    @periods = current_user.periods.all
    render json: @periods
    # cursuser = current_user.email
    # render json: { status: 'SUCCESS',
    #                message: "loaded periods of user #{cursuser}" ,
    #                data: @periods }
  end

  # GET /periods/1
  def show
    render json: @period
  end

  # POST /periods
  def create
    @period = Period.new(period_params)
    @period.user_id = current_user.id
    if @period.save
      render json: @period, status: :created, location: @period
    else
      render json: @period.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /periods/1
  def update
    if @period.update(period_params)
      render json: @period
    else
      render json: @period.errors, status: :unprocessable_entity
    end
  end

  # DELETE /periods/1
  def destroy
    @period.destroy
  end

  # CREATE a new period with the lenght passed as parameter
  # input: :nduration The period duration
  # output: render json with new period data
  def create_period
    periods_checked = current_user.periods.active.count
    puts "The user has #{periods_checked} active periods, trying to create a #{params[:nduration].to_i} days period"
    if !is_a_period_active
      puts "The user hasn't active periods"
      @period = current_user.periods.new(is_active: true, is_updated: false, duration: params[:nduration].to_i, start_date: Date.today.to_s, end_date: (Date.today+params[:nduration].to_i).to_s)
      puts @period
      if @period.save
        render json: @period, status: :created, location: @period
      else
        render json: @period.errors, status: :unprocessable_entity
      end
    else
      puts "The user has active periods"
      # render json: @period.errors, status: :unprocessable_entity
      render json: { status: 'ERROR', message: "The user has an active period"}, status: :unprocessable_entity
    end
  end

  # This method returns all the user periods ordered by date
  def get_periods
    @periods = current_user.periods.all.order(created_at: :desc)
    render json: @periods
  end

  # Return if a period is active
  def check_for_active_periods
    render json: is_a_period_active
  end

  def check_active_period
    render json: @active_period
  end

  def deactivate_active_period
    if is_a_period_active
      @active_period.is_active = false
      @active_period.save
      render json: { 'period': @active_period , 'STATUS': 'PERIOD DEACTIVATED'}
    else
      render json: { status: 'ERROR', message: "The user hasn't an active period"}, status: :unprocessable_entity
    end
  end

  def toggle_updated
    if is_a_period_active
      current_state = @active_period.is_updated
      @active_period.is_updated = !current_state
      @active_period.save
      render json: { 'period': @active_period , 'STATUS': 'UPDATE TOGGLE'}
    else
      render json: { status: 'ERROR', message: "The user hasn't an active period"}, status: :unprocessable_entity
    end
  end

  private

    def is_a_period_active
      !@active_period.nil?
    end

    # Use callbacks to share common setup or constraints between actions.
    def get_active_period
      @active_period = current_user.periods.active.take
    end

    def set_period
      @period = Period.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def period_params
      params.require(:period).permit(:is_active, :is_update, :duration, :start_date, :end_date)
    end
end
