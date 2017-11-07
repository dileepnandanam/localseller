class SellerProductForm extends React.Component {
	constructor(props){
		super(props)
	    this.state = {
	    	error_messages: {
	    		name: '',
	    		price: '',
	    		unit: '',
	    		quantity: '',
	    		description: ''
	    	}
	    }

	    this.submitForm = this.submitForm.bind(this)
	}

	submitForm(e){
		e.preventDefault()
		form_data= {
			product:{
				name: this.refs.name.value,
				price: this.refs.price.value,
				quantity: this.refs.quantity.value,
				unit: this.refs.unit.value,
			}
		}
		that=this
		$.ajax({
			url: this.props.submit_url,
			type: this.props.method,
			datatype: 'json',
			data: form_data,
			success: function(data){				
				if(that.props.method == 'PUT')
					that.props.formSuccess(form_data.product)
				else {
					that.props.formSuccess(data)
				}
			},
			error: function(data){
				state = that.state
				state.error_messages = data.responseJSON
				that.setState(state)
			}
		})
	}

	render(){
		field = this.props.form_values
		return(
		  <div ref='form' className="seller-product-form">
	        <div className='form-group'>
	            <label>Name</label>
	        	<input className='form-control' ref='name' defaultValue={field.name}/>
	        	{this.state.error_messages.name}
	        	
	        </div>
	        
	        <div className='form-group'>
	            <label>Available Quantity</label>
	        	<input className='form-control' ref='quantity' defaultValue={field.quantity}/>
	        	{this.state.error_messages.quantity}
	        </div>

	        <div className='form-group'>
	            <label>Price</label>
	        	<input className='form-control' ref='price' defaultValue={field.price}/>
	        	{this.state.error_messages.price}
	        	
	        </div>

	        
	        <div className='form-group'>
	            <label>How the quantity of product specified, eg: Kg, Litter</label>
	        	<input className='form-control' ref='unit' defaultValue={field.unit}/>
	        	{this.state.error_messages.unit}
	        	
			</div>

	        

	        
	        <div className="seller-product-submit" >
		        <a onClick={this.submitForm}>
		        	Submit
		        </a>
	        </div>
	        <div className='seller-product-submit' >
			    <a  onClick={this.props.hideForm}>
			    	Cancel
			    </a>
		    </div>
		  </div>
		)
	}
}