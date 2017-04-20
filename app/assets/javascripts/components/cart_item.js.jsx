class CartItem extends React.Component {
	constructor(props){
		super(props)
		this.remove_cart_item = this.remove_cart_item.bind(this)
	}
	remove_cart_item(e){
		this.props.remove_cart_item(this.props.item.id, e)
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
				<div className="cart-item-unit" >
				    {item.unit}
				</div>
				<a className="cart-item-delete" onClick={this.remove_cart_item}>
				    {"remove"}
				</a>
				<div className="clearfix" />

			</div>

		)
	}
}