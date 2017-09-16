class ProductQueryHandler
  NEAREST_DISTANCE = 10000

  def initialize(query_params, current_user, scop=nil )
  	@params = query_params
    @scop = scop
    @current_user = current_user
  end

  def result
    collection = Product.order('created_at desc').where('quantity > 0 OR quantity ISNULL')
  	if @params[:search].present?
  	  search_terms = @params[:search].downcase.split(' ')
  	  conditions = search_terms.map{|term|  "searchable LIKE '%#{term}%'"}.join(' AND ')
  	  collection = collection.where(conditions)
  	end

    if @params[:with_location] == "true" && @params[:location][:lat] && @params[:location][:lng]
      nearest_shops = Shop.within_radius(NEAREST_DISTANCE, @params[:location][:lat], @params[:location][:lng])
      collection = collection.where(shop_id: nearest_shops.map(&:id))
    end

    collection = collection.where(@scop) if @scop.present?
  	return collection.paginate(per_page: 12, page: (@params[:page] || 1))
  end
end
