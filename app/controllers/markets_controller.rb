class MarketsController < ApplicationController
	def marketplace

	end

	def search
		lat,lng = params[:geolocation][1..-1].split(', ').map(&:to_f)
		term = params[:term]
		quantity = params[:quantity]
		results = ShopSearch.new(lat, lng, term, quantity).results
		render json: results
	end
	layout 'shop'
end
