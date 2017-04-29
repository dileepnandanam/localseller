class SellerProductForm extends React.Component {
	constructor(props){
		super(props)
	}

	render(){
		return(
	      <form noValidate="novalidate" className="simple_form edit_product" id="edit_product_5" encType="multipart/form-data" action="/seller/shop/products/5" acceptCharset="UTF-8" method="post"><input name="utf8" type="hidden" defaultValue="✓" /><input type="hidden" name="_method" defaultValue="patch" /><input type="hidden" name="authenticity_token" defaultValue="rhtwZAdEpCERPa/1yCudF25Ee9mWrRRfSl/lM6HNcKuV/wqQqC0AucfZrUovAHTn1+oP1UozapqDl3A6YGOlwA==" />  <div className="form-group string required product_name"><label className="control-label string required" htmlFor="product_name"><abbr title="required">*</abbr> Name</label><input className="form-control string required" type="text" defaultValue="dfgh" name="product[name]" id="product_name" /></div>
	        <div className="form-group text optional product_description"><label className="control-label text optional" htmlFor="product_description">Description</label><textarea className="form-control text optional" name="product[description]" id="product_description" defaultValue={""} /></div>
	        <div className="form-group float required product_price"><label className="control-label float required" htmlFor="product_price"><abbr title="required">*</abbr> Price</label><input className="form-control numeric float required" type="number" step="any" defaultValue={45.0} name="product[price]" id="product_price" /></div>
	        <div className="form-group string optional product_unit"><label className="control-label string optional" htmlFor="product_unit">how the quantity of product specified, eg: Kg, Litter</label><input className="form-control string optional" type="text" defaultValue="kg" name="product[unit]" id="product_unit" /></div>
	        <div className="form-group file optional product_image"><label className="control-label file optional" htmlFor="product_image">Image</label><input className="file optional" type="file" name="product[image]" id="product_image" /></div>
	        <input type="submit" name="commit" defaultValue="Update Product" />
	      </form>
		)
	}
}