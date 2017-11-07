class SellerProduct extends React.Component {
	constructor(props){
		super(props)
		product = this.props.product_details
		
		this.state = {
			show_form: false,
			show_image_form: false,
			image_url: product.image_url,
			name: product.name,
			price: product.price,
			unit: product.unit,
			quantity: product.quantity
		}
		this.hideForm = this.hideForm.bind(this)
		this.showForm = this.showForm.bind(this)
		this.showImageForm = this.showImageForm.bind(this)
		this.imageUpload = this.imageUpload.bind(this)
		this.formSuccess = this.formSuccess.bind(this)
		this.deleteProduct = this.deleteProduct.bind(this)
		this.clickImageUpload = this.clickImageUpload.bind(this)
	}
	showForm(){
		state = this.state
		state.show_form=true
		this.setState(state)
	}
	hideForm(){
		state = this.state
		state.show_form=false
		this.setState(state)
	}
	showImageForm(){
		state = this.state
		state.show_image_form=true
		this.setState(state)
	}
	imageUpload(e){
		file = e.target.files[0]
		var fd = new FormData();    
        fd.append('image', file);
        that=this
        $.ajax({
            url: this.props.product_details.image_upload_url,
            data: fd,
            processData: false,
            contentType: false,
            type: 'PUT',
            success: function(data){
                 state = that.state
                 state.image_url = data.image_url
                 state.show_image_form = false
                 that.setState(state)
            } 
        });
	}
	clickImageUpload(){
		this.refs.file.click()
	}

	formSuccess(data){
		state = this.state
		this.hideForm()
		this.setState($(state).extend(data))

	}

	deleteProduct(){
		this.props.deleteProduct(this.props.product_details.id, this.props.product_details.delete_url)
	}
	render(){
		product = this.props.product_details
		form_values = {
			name: product.name,
			price: product.price,
			unit: product.unit,
			description: product.description,
			deliverable: product.deliverable,
			quantity: product.quantity
		}
		image_form = <div className="image-upload"><input ref='file' type='file' onChange={this.imageUpload}/>
		             <input type="button" value="chose image" onClick={this.clickImageUpload}/>
                     </div>   
		form = <div className="seller-product-container">
			    	<SellerProductForm form_values={form_values} submit_url={product.update_url} method={'PUT'} formSuccess={this.formSuccess} hideForm={this.hideForm}/>
		       </div>
		product_details = <div className="seller-product-container">
		        
		        <div className="seller-product-details">
		          <div className="seller-product-name">
		            {this.state.name}
		          </div>
		          <div className="seller-product-price">
		            <div className="seller-product-price-label">
		            	Available
		            </div>
		            {this.state.quantity} {this.state.unit} @ Rs {this.state.price}/{this.state.unit}
		          </div>
		          <div className="seller-product-total">
		            <div className="seller-product-total-label">
		            	total
		            </div>
		            {this.state.quantity * this.state.price}
		          </div>
		        </div>
		        <div className="seller-edit-product pull-left">
		          <a onClick={this.showForm}>
		          	Edit
		          </a>
		        </div>
		        <div className="seller-delete-product pull-left">
		          <a onClick={this.deleteProduct} >
		          	delete
		          </a>
		        </div>
		        <div className="clearfix" />
		       </div>
		return(
			<div className="seller-product-wraper pull-left col-xs-12 col-sm-12 col-md-6 col-lg-3">
			  
		        {this.state.show_form ? form : product_details}
		      
		    </div>
	        

		)
		
	}
}