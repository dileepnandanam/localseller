class AddToCartForm extends React.Component {
	constructor(props){
		super(props)
		this.add_to_cart = this.add_to_cart.bind(this)
		this.state = {
			show_max_limit_msg: false
		}
	}

	add_to_cart(){
		if(this.props.quantity && this.refs.quantity.value > this.props.quantity) {
			this.setState({show_max_limit_msg: true})
		}
		else if(this.refs.quantity.value )
		    this.props.buyHandler(this.refs.quantity.value)
	}
	render() {
		max_limit_msg = 'only' + ' ' + this.props.quantity + ' ' + this.props.unit + ' ' + 'left'
		return(
			
			<div className="product-detail">
			<div className='add_to_cart_form' ref='form-group form_container'>
				<label className="quantity-label pull-left">Quantity</label>
				<input ref='quantity' type='text' className="form-control pull-left quantity-field"/>
				<div className="product-unit pull-left">{this.props.unit}</div>
				<div className="clearfix" />
				<div className="add-to-cart-submit-wraper" >
				  <input type='submit' value="Add to cart" onClick={this.add_to_cart} className="add-to-cart-button btn btn-primary"/>
				  <div className="clearfix"/>
				  {this.state.show_max_limit_msg ? max_limit_msg : ''}
				</div>
			</div>
			</div>
		)
	}

	
}