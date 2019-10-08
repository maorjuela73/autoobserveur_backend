class AdvicesController < ApplicationController

  def get_advices

    @items = Item.find(params[:itemid].to_i).advices.all
    render json: @items

  end

end
