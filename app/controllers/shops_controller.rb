class ShopsController < ApplicationController
  def show
    @shop = Shop.where(permalink: params[:permalink]).first
  end
end