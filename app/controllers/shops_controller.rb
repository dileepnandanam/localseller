class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :new, :create]
  def show
  	@comment = Comment.new
  	@comments = @shop.comments.order('created_at DESC')
  end
  protected
  def set_shop
  	@shop = Shop.where(permalink: params[:permalink]).first
  end
end