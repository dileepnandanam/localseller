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
							<div className="product-name pull-left">
								{product.name}
							</div>
							<div className="product-price pull-right">
								{product.price}
							</div>
							<div className="clearfix"/>
							<div className='submit-wraper'>  
							  <input type="submit" value="buy" className="product-buy btn btn-primary pull-right" onClick={this.formHandler} />
							</div>
							<div className="clearfix" />
						</div>

		
		form = <AddToCartForm buyHandler={this.buyHandler}/>
		return(
			<div className="product-container pull-left col-xs-12 col-sm-12 col-md-6 col-lg-3" >
			<div className='product '>
				<img className="product-image" src={product.image} />
				
				{this.state.show_form ? form : product_details}
			</div>
			</div>
		)
	}
}