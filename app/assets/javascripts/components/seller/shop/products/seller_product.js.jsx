class SellerProduct extends React.Component {
	constructor(props){
		super(props)
	}

	render(){
		product = this.props.product_details

		return(
		  <div className="seller-product-container pull-left col-xs-6 col-sm-4 col-md-4 col-lg-2">
	        <div className="seller-product-image" style={{backgroundImage: 'url(/system/products/images/000/000/005/medium/91uY0y3r0sL._SL1500_.jpg?1493048645)'}} />
	        <div className="seller-product-details">
	          <div className="seller-product-name">
	            dfgh
	          </div>
	          <div className="seller-product-price">
	            Rs 45.0
	          </div>
	        </div>
	        <div className="seller-edit-product pull-left">
	          <a href="/seller/shop/products/5/edit">edit</a>
	        </div>
	        <div className="seller-delete-product pull-left">
	          <a rel="nofollow" data-method="delete" href="/seller/shop/products/5">delete</a>
	        </div>
	        <div className="clearfix" />
	      </div>

		)
		
	}
}