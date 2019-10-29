class MarksController < ApplicationController

  # before_action :set_period, only: [:show, :update, :destroy, :switch_updated, :get_report]
  # before_action :get_active_period, only: [:check_active_period, :check_for_active_periods]
  before_action :authenticate_user

  def create_mark
    # @mark = current_user.periods.active.first.period_items.create(item: Item.find( params[:period_item][:item_id] ))
    @mark = Mark.create(period_item_id: params[:mark][:period_item_id],value: params[:mark][:value],comment: params[:mark][:comment])
    puts "params ++++++++++++++"
    puts @mark.inspect
    puts "++++++++++++++++++++ Funcionó! ++++++++++++++++++++++++++"
  end

  private

  # Only allow a trusted parameter "white list" through.
  def mark_params
    params.require(:mark).permit(:period_item_id, :value, :comment)
  end



end
