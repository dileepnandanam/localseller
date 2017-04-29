class SellerProducts extends React.Component {
	constructor(props){
		super(props)

	}


	render(){
		products = this.props.products.map(function(product){
			return(	
				<SellerProduct product_details={product} key={product.id}/>
			)
		})
		return(
			<div className='seller-products'>
			    {products}
			</div>
		)
	}

}