class CartItem extends React.Component {
	constructor(props){
		super(props)
		this.remove_cart_item = this.remove_cart_item.bind(this)
	}
	remove_cart_item(){
		this.props.remove_cart_item(this.props.item.id)
	}

	render(){
		item = this.props.item
		return(
			<div className="cart-item">
				<div className="cart-item-name" >
				    {item.name}
				</div>
				<div className="cart-item-quantity" >
				    {item.quantity}
				</div>
				<a className="cart-item-delete" hred="#" onClick={this.remove_cart_item}>
				    {"remove"}
				</a>
				<div className="clearfix" />

			</div>

		)
	}
}