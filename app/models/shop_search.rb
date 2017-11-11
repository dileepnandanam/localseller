class ShopSearch
  def initialize(lat, lng, term, quantity)
  	@lat = lat
  	@lng = lng
  	@quantity = quantity || 1
    @term = term
    if term.present?
  	  search_terms = term.downcase.split(' ')
  	  @search_conditions = search_terms.map{|term|  "products.searchable LIKE '%#{term}%'"}.join(' AND ')
    end
  end

  def results
  	collection = Product.unscoped.where("products.deleted = '0'")
  	  .joins('inner join shops on products.shop_id = shops.id')
  	collection = collection.where(@search_conditions) if @term.present?
  	collection = collection.where("products.quantity >= #{@quantity}")
  	  .select(%{
  	  	products.id as id,
  	  	products.name AS name,
  	  	products.price AS price,
  	  	shops.lat as lat,
  	  	shops.lng as lng,
  	  	round((gc_to_sec(earth_distance(ll_to_earth(shops.lat, shops.lng), ll_to_earth(#{@lat}, #{@lng})))/1000)::numeric, 2) AS distance,
  	  	(#{@quantity} * products.price) AS total
  	  }).order('distance ASC')
  end
end