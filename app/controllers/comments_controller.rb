class CommentsController < ShopsController
  before_action :set_shop, only: [:show, :new, :create]
  def new
    @comment = Comment.new(parent_id: params[:parent_id])
    render 'shops/comments/new', layout: false
  end
  def create
    if current_user.nil?
      redirect_to new_user_registration_path and return 
    end

    @comment = Comment.new(comments_params.merge(shop_id: @shop.id, user_id: current_user.id))
    if @comment.save
      render 'shops/comments/comment', layout: false, status: 200
    else
      render nothing: true, status: 422
    end
  end
  protected
  def set_shop
    @shop = Shop.find_by_permalink(params[:shop_id])
  end
  def comments_params
    params.require(:comment).permit(:text, :parent_id)
  end
end