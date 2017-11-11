class MarketsController < ApplicationController
	def marketplace

	end

	def search
		lat,lng = params[:geolocation][1..-1].split(', ').map(&:to_f)
		term = params[:term]
		quantity = params[:quantity]
		results = ShopSearch.new(lat, lng, term, quantity, nil).results
		render json: results
	end

	def initial_results
		lat,lng = params[:geolocation][1..-1].split(', ').map(&:to_f)
		results = ShopSearch.new(lat, lng, nil, nil, 10).results
		render json: results
	end

	layout 'shop'
end
