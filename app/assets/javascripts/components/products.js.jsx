class Products extends React.Component {
	constructor(props) {
		super(props)
		
		this.state = {
			query: {page: 1, with_location: false},
			products: [],
			cart: []
		}

		
		this.get_loc = this.get_loc.bind(this)
		this.get_products = this.get_products.bind(this)
		this.add_to_cart = this.add_to_cart.bind(this)
		this.remove_cart_item = this.remove_cart_item.bind(this)
		this.checkout = this.checkout.bind(this)
		this.load_more= this.load_more.bind(this)
		this.search_handle = this.search_handle.bind(this)
		this.get_cart = this.get_cart.bind(this)
		this.string_search = this.string_search.bind(this)
		this.location_wise_search = this.location_wise_search.bind(this)


		this.get_products({page: 1})
		this.get_cart()
		this.get_loc()
	}
	get_loc(){
		that=this
		$.ajax({
			url: '/get_location',
			datatype: 'json'
		}).success(function(data){
			that.setState({
				query: $.extend(that.state.query, data),
				products: that.state.products,
				cart: that.state.cart
			})
		})
	}
	load_more(){
		query = {search: this.state.query.search, page: this.state.query.page, location: this.state.query.location, with_location: this.state.query.with_location}
		query.page = query.page + 1
		this.get_products(query)
	}
	search_handle(query){
		this.setState({
			query: $.extend(query,{location: this.state.query.location, with_location: this.state.query.with_location}),
			data: this.state.data,
			cart: this.state.cart
		})
		this.get_products(query)
	}
	get_cart(){
		that = this
		$.ajax({
			url: that.props.current_cart_url,
			dataType: 'json',
			type: 'get' 
		}).success(function(data) {
			that.setState({
				cart: data,
				data: that.state.data,
				query: that.state.query
			})
		})
	}

	get_products(query) {

		that = this
		$.ajax({
			data: query,
			type: 'get',
			dataType: 'json',
			url: this.props.products_url
		}).success(function(data){
			new_state = that.state
			if(query.page != that.state.query.page){
				for(i=0; i< data.length; i++)
					new_state.products.push(data[i])
			} else {
				new_state.products = data
			}
			new_state.query = query
			
			that.setState(new_state)
		})

	}
	remove_cart_item(id, e){
		$.ajax({
			url: this.props.remove_purchase_url,
			type: 'delete',
			data: {id: id},
			dataType: 'json'
		})

		state = this.state
		cart = state.cart
		for(i=0; i<cart.length; i++){
			if(cart[i].id == id)
				index= i
		}
		cart.splice(index, 1)
		this.setState({
			query: this.state.query,
			products: this.state.products,
			cart: cart
		})
	}

	add_to_cart(quantity, product_id, unit, name){
		new_cart_entry = {name: name, quantity: quantity, product_id: product_id, unit: unit}
		$.ajax({
			url: this.props.add_to_cart_url,
			data: new_cart_entry,
			type: 'post'
		}).success(function(data){
			state = that.state
			cart = state.cart
			new_cart_entry['id'] = data['id']
			cart.push(new_cart_entry)
			that.setState({
				query: that.state.query,
				products: that.state.products,
				cart: cart
			})
		})
		
	}
	location_wise_search(){
		query = this.state.query
		query = $.extend(query, {with_location: true})
		this.get_products(query)
		this.setState({
			query: query,
			products: this.state.products,
			cart: this.state.cart
		})
	}
	
	string_search(){
		query = this.state.query
		query = $.extend(query, {with_location: false})
		this.get_products(query)
		this.setState({
			query: query,
			products: this.state.products,
			cart: this.state.cart
		})
	}
	checkout(){
		if(this.props.current_user)
		    window.location = this.props.checkout_url
		else
			window.location = 'users/sign_up'
	}
	render() {
		that= this
		products = this.state.products.map(function(product) {
			return(
				<Product product_details={product} current_user={that.props.current_user} add_to_cart={that.add_to_cart} key={'product'+product.id} />
			)
		})
		cart = this.state.cart.map(function(item){
			return(
				<CartItem item={item} remove_cart_item={that.remove_cart_item} key={item.id}/>
			)
		})
		local_search_button  = <input type="button"  value="search nearby" className="search-button btn btn-primary" onClick={this.location_wise_search}/>
		global_search_button  = <input type="button" value="search globally" className="search-button btn btn-primary" onClick={this.string_search}/>
		checkout_button = <input className="cart-checkout btn btn-primary" value="Checkout" type="submit" onClick={this.checkout}/>
		load_more_button = <div onClick={this.load_more} className="load-more-button">Load more</div>
		return(
			<div className="product-list">

			    <div className='sub-navbar'>
			    	<SearchBox search_handle={this.search_handle}/>
			    	{this.state.query.with_location ? global_search_button : local_search_button}
				</div>
				{products}

				<div className="clearfix" />
					{products.length % this.props.per_page == 0 && products.length > 0 ? load_more_button : ''}
				<div className="shopping-cart">
				    {cart.length >0 ? checkout_button: ''}	
					{cart}
				</div>
			</div>
		)
	}
}