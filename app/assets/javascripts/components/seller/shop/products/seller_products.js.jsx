class SellerProducts extends React.Component {
	constructor(props){
		super(props)

		this.state = { products: this.props.products, show_form: false }
		this.deleteProduct = this.deleteProduct.bind(this)
		this.formSuccess = this.formSuccess.bind(this)
		this.hideForm = this.hideForm.bind(this)
		this.showForm = this.showForm.bind(this)
	}
	deleteProduct(id, delete_url){
		delete_item = confirm("Are you sure you want to delete?");
		that=this
		if(delete_item)
		$.ajax({
			data: id,
			url: delete_url,
			type: 'DELETE'
		}).success(function(){
            var index
			for(i=0; i< that.state.products.length; i++){
				if(that.state.products[i].id == id)
					index=i
			}
			state=that.state
			state.products.splice(index,1)
			that.setState(state)

		})
			
	}
	showForm(){
		state= this.state
		state.show_form = true
		this.setState(state)
	}
	hideForm(){
		state= this.state
		state.show_form = false
		this.setState(state)
	}

	formSuccess(product){
		this.hideForm()
		state = this.state
		reverse = state.products.reverse()
		reverse.push(product)
		state.products = reverse.reverse()
		this.setState(state)

	}

	render(){
		that=this
		products = this.state.products.map(function(product){
			return(	
				<SellerProduct product_details={product} deleteProduct={that.deleteProduct} key={product.id}/>
			)
		})
		form_values = {
			name: "",
			price: "",
			unit: ""
		}
		form = <div className="seller-product-wraper pull-left col-xs-12 col-sm-12 col-md-6 col-lg-3">
					 <div className="seller-product-container">
					       <SellerProductForm form_values={form_values} submit_url={this.props.create_product_url} method={'POST'} formSuccess={this.formSuccess} hideForm={this.hideForm}/>
					 </div>
			    </div>
		add_product = <div onClick={this.showForm} className="seller-product-wraper show-form pull-left col-xs-12 col-sm-12 col-md-6 col-lg-3">
		                <div className="seller-product-container">
		                	<div className="add-product">
		                		Create listing
		                		<br />
		                		<div className="add-product-ico-container" style={{textAlign:"center"}}>
		                			<i className="fa fa-plus-circle add-product-ico" align="center"/>
		                		</div>
		                	</div>
		                </div>
		              </div>
		return(
			<div className='seller-products'>
			    {this.state.show_form ? form : add_product}
			    {products}
			    <div className='clearfix' />
			    
			</div>
		)
	}

}