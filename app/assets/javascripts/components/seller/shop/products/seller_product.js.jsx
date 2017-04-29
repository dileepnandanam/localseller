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
			unit: product.unit
		}
		this.hideForm = this.hideForm.bind(this)
		this.showForm = this.showForm.bind(this)
		this.showImageForm = this.showImageForm.bind(this)
		this.imageUpload = this.imageUpload.bind(this)
		this.formSuccess = this.formSuccess.bind(this)
		this.deleteProduct = this.deleteProduct.bind(this)
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
	formSuccess(data){
		this.setState($(data).extend(this.state))
	}

	deleteProduct(){
		this.props.deleteProduct(this.props.product_details.id, this.props.product_details.delete_url)
	}
	render(){
		product = this.props.product_details
		form_values = {
			name: product.name,
			price: product.price,
			unit: product.unit
		}
		image_form = <input ref='file' type='file' onChange={this.imageUpload}/>
                         
		form = <SellerProductForm form_values={form_values} submit_url={product.update_url} method={'PUT'} formSuccess={this.formSuccess} hideForm={this.hideForm}/>
		return(
		  <div className="seller-product-container pull-left col-xs-6 col-sm-4 col-md-4 col-lg-2">
	        <i className="fa fa-camera-retro" onClick={this.showImageForm}></i>
	        {this.state.show_image_form ? image_form : ''}
	        <div className="seller-product-image" style={{backgroundImage: 'url('+ this.state.image_url +')'}} />
	        <div className="seller-product-details">
	          <div className="seller-product-name">
	            {this.state.name}
	          </div>
	          <div className="seller-product-price">
	            Rs {this.state.price}
	          </div>
	        </div>
	        <div className="seller-edit-product pull-left">
	          <input type="button" onClick={this.showForm} value='edit'/>
	        </div>
	        <div className="seller-delete-product pull-left">
	          <input type='button' onClick={this.deleteProduct} value='delete'/>
	        </div>
	        <div className="clearfix" />
	        {this.state.show_form ? form : ''}

	         
	      </div>
	        

		)
		
	}
}