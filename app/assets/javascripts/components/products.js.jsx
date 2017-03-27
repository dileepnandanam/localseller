class Products extends React.Component {
	constructor(props) {
		super(props)
		this.state = {
			query: {page: 1},
			products: [],
			cart: []
		}

		this.get_products = this.get_products.bind(this)
		this.add_to_cart = this.add_to_cart.bind(this)
		this.remove_cart_item = this.remove_cart_item.bind(this)
		this.checkout = this.checkout.bind(this)
		this.load_more= this.load_more.bind(this)
		this.search_handle = this.search_handle.bind(this)
		this.get_cart = this.get_cart.bind(this)
		this.get_products({page: 1})
		this.get_cart()
	}
	load_more(){
		query = {search: this.state.query.search, page: this.state.query.page}
		query.page = query.page + 1
		this.get_products(query)
	}
	search_handle(query){
		this.setState({
			query: query,
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
	remove_cart_item(id){
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

	add_to_cart(quantity, product_id, name, shop_id){
		new_cart_entry = {name: name, quantity: quantity, product_id: product_id, shop_id: shop_id}
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

			state = this.state
			cart = state.cart
			new_cart_entry = {name: name, quantity: quantity, product_id: product_id, shop_id: shop_id}
			cart.push(new_cart_entry)
			this.setState({
				query: this.state.query,
				products: this.state.products,
				cart: cart
			})
		
	}
	checkout(){
		$.ajax({
			type: 'post',
			data: {purchases: this.state.cart},
			url: this.props.shoping_cart_url
		}).success(function(data){
			window.location = data.url
		})
	}
	render() {
		that= this
		products = this.state.products.map(function(product) {
			return(
				<Product product_details={product} current_user={that.props.current_user} add_to_cart={that.add_to_cart} key={product.id} />
			)
		})
		cart = this.state.cart.map(function(item){
			return(
				<CartItem item={item} remove_cart_item={that.remove_cart_item} key={item.id}/>
			)
		})
		checkout_button = <input className="cart-checkout" value="Checkout" type="submit" onClick={this.checkout}/>
		load_more_button = <div onClick={this.load_more} className="load-more-button">Load more</div>
		return(
			<div className="product-list">
			    <SearchBox search_handle={this.search_handle}/>
				{products}
				<div className="clearfix" />
					{products.length % this.props.per_page == 0 ? load_more_button : ''}
				<div className="shopping-cart">
				    {cart.length >0 ? checkout_button: ''}	
					{cart}
				</div>
			</div>
		)
	}
}