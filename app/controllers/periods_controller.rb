class PeriodsController < ApplicationController

  require 'json'

  before_action :set_period, only: [:show, :update, :destroy, :switch_updated, :get_report]
  before_action :get_active_period, only: [:check_active_period, :check_for_active_periods, :get_completion_percentage]
  before_action :authenticate_user

  # GET /periods
  def index
    @periods = current_user.periods.all
    render json: @periods
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
    if periods_checked == 0
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

  # This method returns the inactive user periods ordered by date
  def get_inactive_periods
    @periods = current_user.periods.where(is_active: false).order(created_at: :desc)
    render json: @periods
  end

  # Return a boolean telling if a period is active
  def check_for_active_periods
    # puts "answer #{ @active_period.count() > 0 }"
    render json: { 'activePeriod': @active_period.count() > 0 }
  end

  # Return the active period
  def check_active_period
    render json: @active_period
  end

  def get_completion_percentage
    period = @active_period.first
    elapsed_days = (Date.current - period.start_date).to_i
    percentage =  (Date.current - period.start_date).to_f/period.duration
    render json:  { 'elapsed_days': elapsed_days, 'duration': period.duration, 'completion_percentage': percentage}
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

  def get_report
    entries = []
    entries = @period.items.map do |i|
      { 'code': i.code, 'name': i.name}
    end
    render json: { 'total_days' => @period.duration,
                   'measured_days' => [(Date.today-@period.start_date.to_date).to_i , @period.duration].min,
                   'start_date' => @period.start_date,
                   'end_date' => @period.end_date,
                   # 'average_per_day' => [ { 'date': '2019-04-01', 'average': '3' },
                   #                    #                    #                        { 'date': '2019-04-02', 'average': '3.45' },
                   #                    #                    #                        { 'date': '2019-04-03', 'average': '4.68'},
                   #                    #                    #                        { 'date': '2019-04-04', 'average': '3.2' },
                   #                    #                    #                        { 'date': '2019-04-05', 'average': 'null' },
                   #                    #                    #                        { 'date': '2019-04-06', 'average': '3' },
                   #                    #                    #                        { 'date': '2019-04-07', 'average': '3.45' },
                   #                    #                    #                        { 'date': '2019-04-08', 'average': '4.68' },
                   #                    #                    #                        { 'date': '2019-04-09', 'average': 'null' },
                   #                    #                    #                        { 'date': '2019-04-10', 'average': 'null' },
                   #                    #                    #                        { 'date': '2019-04-11', 'average': 'null' },
                   #                    #                    #                        { 'date': '2019-04-12', 'average': 'null' },
                   #                    #                    #                        { 'date': '2019-04-13', 'average': 'null' },
                   #                    #                    #                        { 'date': '2019-04-14', 'average': 'null' },
                   #                    #                    #                        { 'date': '2019-04-15', 'average': 'null' },
                   #                    #                    #                        { 'date': '2019-04-16', 'average': 'null' },
                   #                    #                    #                        { 'date': '2019-04-17', 'average': 'null' },
                   #                    #                    #                        { 'date': '2019-04-18', 'average': 'null' },
                   #                    #                    #                        { 'date': '2019-04-19', 'average': 'null' },
                   #                    #                    #                        { 'date': '2019-04-20', 'average': 'null' } ],
                   'average_per_day' => entries,
                   'average_per_item' => [ {'Item 1': '3'} ,
                                           {'Item 2': '3.45'} ,
                                           {'Item 3': '4.68'} ]
    }
  end

  def period_report

    puts "++++++++++++++ Period report +++++++++++"
    entries = []

    for i in current_user.periods.find(params[:periodid]).items do
      n_item = i.as_json
      n_marks = []
      for j in PeriodItem.where(period_id: params[:periodid], item_id: i.id).first.marks do
        n_marks.push(j.as_json)
      end
      n_item["marks"] = n_marks
      entries.push(n_item)
    end

    render json: entries
    puts "++++++++++++++ Period report END +++++++++++"

  end

  def period_report_filtered

    puts "++++++++++++++ Period report +++++++++++"
    entries = []

    for i in current_user.periods.find(params[:periodid]).items do
      n_item = i.as_json
      n_marks = []
      is_updated = false
      for j in PeriodItem.where(period_id: params[:periodid], item_id: i.id).first.marks do
        puts j.as_json.to_s
        mark_date = j.created_at.to_date.to_s
        cur_date = (Time.zone.now.to_date.to_s)
        is_updated = (mark_date == cur_date)
        n_marks.push(j.as_json)
      end
      n_item["marks"] = n_marks

      unless is_updated
        entries.push(n_item)
      end
    end

    render json: entries
    puts "++++++++++++++ Period report END +++++++++++"

  end

  private

  def is_a_period_active
    puts "++++Active period ++++"
    puts @active_period.to_s
    !@active_period.nil?
  end

  # Use callbacks to share common setup or constraints between actions.
  def get_active_period
    # puts 'ejecutando get_active_period'
    @active_period = current_user.periods.active
    # puts 'get_active_period ejecutado'
  end

  def set_period
    @period = Period.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def period_params
    params.require(:period).permit(:is_active, :is_updated, :duration, :start_date, :end_date)
  end

end
