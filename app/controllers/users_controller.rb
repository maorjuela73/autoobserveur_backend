class UsersController < ApplicationController
  before_action :authenticate_user, only: [:index, :show, :update, :destroy]
  before_action :set_current_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    render json: @users
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
                   'average_per_day' => {  '2019-04-01' => '3',
                                           '2019-04-02' => '3.45',
                                           '2019-04-03' => '4.68',
                                           '2019-04-04' => '3.2',
                                           '2019-04-05' => 'null',
                                           '2019-04-06' => '3',
                                           '2019-04-07' => '3.45',
                                           '2019-04-08' => '4.68',
                                           '2019-04-09' => 'null',
                                           '2019-04-10' => 'null',
                                           '2019-04-11' => 'null',
                                           '2019-04-12' => 'null',
                                           '2019-04-13' => 'null',
                                           '2019-04-14' => 'null',
                                           '2019-04-15' => 'null',
                                           '2019-04-16' => 'null',
                                           '2019-04-17' => 'null',
                                           '2019-04-18' => 'null',
                                           '2019-04-19' => 'null',
                                           '2019-04-20' => 'null'} ,
                   'average_per_item' => { 'Item 1' => '3',
                                           'Item 2' => '3.45',
                                           'Item 3' => '4.68' }
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
      params.require(:user).permit(:first_name, :last_name, :email, :birth_date, :password, :password_confirmation)
    end
end
