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
				unit: this.refs.unit.value,
				description: this.refs.description.value,
				deliverable: this.refs.deliverable.checked
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
				else 
					that.props.formSuccess(data)
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
		  <div ref='form'>
	        <div className='form-group'>
	            <label>Name</label>
	        	<input className='form-control' ref='name' defaultValue={field.name}/>
	        	{this.state.error_messages.name}
	        	
	        </div>
	        <div className='form-group'>
	            <label>description</label>
	        	<textarea className='form-control' ref='description' defaultValue={field.description}/>
	        	{this.state.error_messages.description}
	        	
	        </div>

	        <div className='form-group'>
	            <label>price</label>
	        	<input className='form-control' ref='price' defaultValue={field.price}/>
	        	{this.state.error_messages.price}
	        	
	        </div>

	        <div className='form-group'>
	            <label>How the quantity of product specified, eg: Kg, Litter</label>
	        	<input className='form-control' ref='unit' defaultValue={field.unit}/>
	        	{this.state.error_messages.unit}
	        	
	        </div>

	        <div className='form-group'>
	            <label>Can deliver to the buyer
	        	    <input type="checkbox" className='form-control' ref='deliverable' defaultChecked={field.deliverable}/>
	        	</label>
	        </div>

	        <input type='submit' className='btn btn-primary seller-product-submit ' value='submit' onClick={this.submitForm} />
		    <input type='button' className='btn btn-primary seller-product-submit' value="cancel"  onClick={this.props.hideForm} />
		  </div>
		)
	}
}