class SellerProductForm extends React.Component {
	constructor(props){
		super(props)
	    this.state = {
	    	error_messages: {
	    		name: '',
	    		price: '',
	    		unit: ''
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
				unit: this.refs.unit.value
			}
		}
		that=this
		$.ajax({
			url: this.props.submit_url,
			type: this.props.method,
			datatype: 'json',
			data: form_data,
			success: function(data){
				that.props.formSuccess(form_data.products)
			},
			error: function(data){
				state = this.state
				state.error_messages = data.error_messages
				this.setState(state)
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
	            <label>price</label>
	        	<input className='form-control' ref='price' defaultValue={field.price}/>
	        	{this.state.error_messages.price}
	        	
	        </div>

	        <div className='form-group'>
	            <label>How the quantity of product specified, eg: Kg, Litter</label>
	        	<input className='form-control' ref='unit' defaultValue={field.unit}/>
	        	{this.state.error_messages.unit}
	        	
	        </div>
	        <input type='submit' value='submit' onClick={this.submitForm} />
		  </div>
		)
	}
}