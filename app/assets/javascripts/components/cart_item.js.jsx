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
			<tr className="cart-item">
				<td className="cart-item-name" >
				    {item.name}
				</td>
				<td className="cart-item-quantity" >
				    {item.quantity}
				</td>
				<td className="cart-item-unit" >
				    {item.unit}
				</td>
				<td>
				<a className="cart-item-delete" onClick={this.remove_cart_item}>
				    {"remove"}
				</a>
				</td>
			</tr>

		)
	}
}