class ProductQueryHandler
  def initialize(query_params)
  	@params = query_params
  end

  def result

  	if @params[:search].present?
  	  search_terms = @params[:search].split(' ')
  	  conditions = search_terms.map{|term|  "name LIKE '%#{term}%'"}.join(' OR ')
  	  collection = Product.where(conditions)
  	else
  	  collection = Product.order('created_at desc')
  	end
  	return collection.paginate(per_page: 10, page: (@params[:page] || 1))
  end
end