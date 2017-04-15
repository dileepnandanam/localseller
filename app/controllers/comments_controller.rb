class CommentsController < ShopsController
  before_action :set_shop, only: [:show, :new, :create]
  def new
    @comment = Comment.new
    render 'shops/comments/new', layout: false
  end
  def create
    redirect_to user_signup_path if current_user.nil?
    if Comment.create(comments_params.merge(shop_id: @shop.id, user_id: current_user.id))
      render 'shops/comments/feedback', layout: false, status: 200
    else
      render nothing: true, status: 422
    end
  end
  protected
  def set_shop
    @shop = Shop.find_by_permalink(params[:shop_id])
  end
  def comments_params
    params.require(:comment).permit(:text)
  end
end