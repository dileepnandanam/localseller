class Product extends React.Component {
	constructor(props){
		super(props)
		this.buyHandler = this.buyHandler.bind(this)
		this.formHandler = this.formHandler.bind(this)
		this.state = {
			show_form: false
		}
	}
	buyHandler(quantity){
		product = this.props.product_details
		this.props.add_to_cart(quantity, product.id, product.name, product.shop_id)
		this.setState({
			show_form: false
		})
	}
	formHandler(){
		
		if(this.props.current_user) {
			this.setState({
				show_form: true
			})
		}
		else {
			window.location = '/users/sign_up'
		}
	}
	render(){
		product = this.props.product_details
		product_details = <div className="product-detail">
							<div className="product-shop-name">
								<a href={product.shop_url}>{product.shop_name}</a>
							</div>
							<div className="product-name">
								{product.name}
							</div>
							<div className="product-price pull-left">
								{product.price}
							</div>
							<input type="submit" value="buy" className="product-buy pull-right" onClick={this.formHandler} />
							<div className="clearfix" />
						</div>

		
		form = <AddToCartForm buyHandler={this.buyHandler}/>
		return(
			<div className='product pull-left col-xs-6 col-sm-6 col-md-4 col-lg-3'>
				<img className="product-image" src={product.image} />
				
				{this.state.show_form ? form : product_details}
			</div>
		)
	}
}