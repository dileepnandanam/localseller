class SellerProductForm extends React.Component {
	constructor(props){
		super(props)
	    this.state = {
	    	error_messages: {
	    		name: '',
	    		price: '',
	    		unit: '',
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
				quantity: this.refs.quantity.value
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
					that.refs.name.value('')
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
	        	
	        </div>

	        <div className='form-group'>
	            <label>Rate Per Kg</label>
	        	<input className='form-control' ref='price' defaultValue={field.price}/>
	        	{this.state.error_messages.price}
	        	
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