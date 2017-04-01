class ProductQueryHandler
  def initialize(query_params, scop=nil)
  	@params = query_params
    @scop = scop
  end

  def result

  	if @params[:search].present?
  	  search_terms = @params[:search].downcase.split(' ')
  	  conditions = search_terms.map{|term|  "searchable LIKE '%#{term}%'"}.join(' AND ')
  	  collection = Product.where(conditions)
  	else
  	  collection = Product.order('created_at desc')
  	end

    collection = collection.where(scop) if @scop.present?
  	return collection.paginate(per_page: 10, page: (@params[:page] || 1))
  end
end