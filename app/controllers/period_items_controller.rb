class PeriodItemsController < ApplicationController

  # before_action :set_period, only: [:show, :update, :destroy, :switch_updated, :get_report]
  # before_action :get_active_period, only: [:check_active_period, :check_for_active_periods]
  before_action :authenticate_user

  def create_period_item
    @periodItem = current_user.periods.active.first.period_items.create(item: Item.find( params[:period_item][:item_id] ))
  end



  private

  # Only allow a trusted parameter "white list" through.
  def period_item_params
    params.require(:period_item).permit(:period_id, :item_id)
  end

end
