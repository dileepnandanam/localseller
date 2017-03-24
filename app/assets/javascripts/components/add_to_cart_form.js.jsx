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
			<div className='add_to_cart_form' ref='form_container'>
				<label className="quantity-label">Quantity</label>
				<input ref='quantity' type='text' className="quantity-field"/>
				<input type='submit' value="Add to cart" onClick={this.add_to_cart} className="add-to-cart-button"/>
			</div>
		)
	}

	
}