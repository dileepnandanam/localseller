class AddToCartForm extends React.Component {
	constructor(props){
		super(props)
		this.add_to_cart = this.add_to_cart.bind(this)
	}

	add_to_cart(){
		if(this.refs.quantity.value)
		    this.props.buyHandler(this.refs.quantity.value)
	}
	render() {
		return(
			<div className="product-detail">
			<div className='add_to_cart_form' ref='form-group form_container'>
				<label className="quantity-label pull-left">Quantity</label>
				<input ref='quantity' type='text' className="form-control pull-right quantity-field"/>
				<div className="clearfix" />
				<div className="add-to-cart-submit-wraper" >
				  <input type='submit' value="Add to cart" onClick={this.add_to_cart} className="add-to-cart-button"/>
				  <div className="clearfix"/>
				</div>
			</div>
			</div>
		)
	}

	
}