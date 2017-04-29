class SellerProducts extends React.Component {
	constructor(props){
		super(props)
		this.state = { products: this.props.products }
		this.deleteProduct = this.deleteProduct.bind(this)
	}
	deleteProduct(id, delete_url){
		that=this
		$.ajax({
			data: id,
			url: delete_url,
			type: 'DELETE'
		}).success(function(){
            var index
			for(i=0; i< this.state.length; i++){
				if(this.state[i].id == id)
					index=i
			}
			state=that.state
			state.products.splice(index,1)
			that.setState(state)

		})
			
	}

	render(){
		that=this
		products = this.state.products.map(function(product){
			return(	
				<SellerProduct product_details={product} deleteProduct={that.deleteProduct} key={product.id}/>
			)
		})
		return(
			<div className='seller-products'>
			    {products}
			</div>
		)
	}

}