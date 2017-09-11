class Product extends React.Component {
	constructor(props){
		super(props)
		this.state = {
			show_form: false,
			zoom: false,
			show_description: false
		}
		this.zoom_drag = this.zoom_drag.bind(this)
		this.buyHandler = this.buyHandler.bind(this)
		this.formHandler = this.formHandler.bind(this)
		this.zoom_toggle = this.zoom_toggle.bind(this)
		
	}
	buyHandler(quantity){
		product = this.props.product_details
		this.props.add_to_cart(quantity, product.id, product.unit, product.name, product.shop_id)
		this.setState({
			show_form: false
		})
	}
	formHandler(){
		
		this.setState({
			show_form: true
		})
	}
	zoom_toggle(){
		
		this.setState({
			show_form: this.state.show_form,
			zoom: !this.state.zoom,
			product_description: !this.state.product_description
		})
	}

	zoom_drag(e){
	   scale = 1
       offset = $(e.target).closest('.product').offset()
       origin_x = offset.left
       origin_y = offset.top
      
       cursor_x = e.pageX-origin_x
       cursor_y = e.pageY-origin_y

	   $(e.target).css('left', cursor_x  - $(e.target).width()/2)
	   $(e.target).css('top',  cursor_y  - $(e.target).height()/2)

		
	}
	



	render(){
		product = this.props.product_details
		product_details = <div className="product-detail">
							<div className="product-name">
								{product.name}
							</div>

							<div className="product-shop-name">
								<a href={product.shop_url}>{product.shop_name}</a>
							</div>
							
							<div className="product-price">
								{product.price}
							</div>
							
							<div className='submit-wraper'>  
							  <input type="submit" value="buy" className="product-buy btn btn-primary pull-right" onClick={this.formHandler} />
							</div>
							<div className="clearfix" />
						</div>
		product_description = <div className="description-container">    
								<div className="product-description pull-left" >
									<div className="description-name">
										<h4>{product.name}</h4>
									</div>
									<p>{product.description}</p>
								  </div>
							  </div>

		
		large_image = <img style={{top:-125,left:-125}} className="zoomer" src={product.large_image} onClick={this.zoom_toggle} onMouseDown={this.zoom_drag} onMouseMove={this.zoom_drag}/>
		small_image = <img className="product-image" onMouseDown={this.zoom_toggle} src={product.image} />
		form = <AddToCartForm buyHandler={this.buyHandler} unit={product.unit} quantity= {product.quantity}/>
		return(
			<div className="product-container pull-left col-xs-6 col-sm-6 col-md-4 col-lg-3" >
				<div className='product pull-left'> 
				    {this.state.zoom ? large_image : ''}
				    {small_image}
					
					{this.state.show_form ? form : product_details}
				</div>
				{this.state.product_description ? product_description : ''}
				
			</div>
		)
	}
}