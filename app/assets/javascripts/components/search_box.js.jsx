class SearchBox extends React.Component {
	constructor(props){
		super(props)
		this.inputHandler = this.inputHandler.bind(this)
	}
	inputHandler(e){
		console.log(e)
		this.props.search_handle({search: e.target.value, page: 1})
	}
	render(){
		return(
			<div className='search-container form-group'>
				<input className="form-control" type="text" onChange={this.inputHandler} />
			</div>
		)
	}
}