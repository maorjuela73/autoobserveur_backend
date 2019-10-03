class UsersController < ApplicationController
  before_action :authenticate_user, only: [:index, :show, :update, :destroy, :get_current_user]
  before_action :set_current_user, only: [:show, :update, :destroy, :get_current_user]

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /current_user
  def get_current_user
    render json: @user
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def get_user_statistics
    render json: { 'total_days' => '20',
                   'measured_days' => '8',
                   'start_date' => '2019-04-01',
                   'end_date' => '2019-04-20',
                   'average_per_day' => [ { 'date': '2019-04-01', 'average': '0' },
                                          { 'date': '2019-04-02', 'average': '1' },
                                          { 'date': '2019-04-03', 'average': '4.68'},
                                          { 'date': '2019-04-04', 'average': '3.2' },
                                          { 'date': '2019-04-05', 'average': '4' },
                                          { 'date': '2019-04-06', 'average': '3' },
                                          { 'date': '2019-04-07', 'average': '3.45' },
                                          { 'date': '2019-04-08', 'average': '4.68' },
                                          { 'date': '2019-04-09', 'average': '4.3' },
                                          { 'date': '2019-04-10', 'average': '4.2' },
                                          { 'date': '2019-04-11', 'average': '3.9' },
                                          { 'date': '2019-04-12', 'average': '4.0' },
                                          { 'date': '2019-04-13', 'average': '4.23' },
                                          { 'date': '2019-04-14', 'average': '4.46' },
                                          { 'date': '2019-04-15', 'average': '4.9' },
                                          { 'date': '2019-04-16', 'average': '4.95' },
                                          { 'date': '2019-04-17', 'average': 'null' },
                                          { 'date': '2019-04-18', 'average': 'null' },
                                          { 'date': '2019-04-19', 'average': 'null' },
                                          { 'date': '2019-04-20', 'average': 'null' } ],
                   'average_per_item' => [ {'C1': '3.7'} ,
                                           {'C2': '4.45'} ,
                                           {'C3': '3.45'} ,
                                           {'A1': '4.5'} ,
                                           {'A2': '2.45'} ,
                                           {'A3': '3.2'} ,
                                           {'A5': '5'} ,
                                           {'A12': '2.9'} ]
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.

  def set_current_user
    @user = current_user
  end

  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :birth_date, :gender, :password, :password_confirmation)
  end

end
