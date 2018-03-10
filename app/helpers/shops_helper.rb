module ShopsHelper
  def new_bids_count
    product_bids = ::Bid.not_accepted.last_on_top.where(product_id: @shop.products.pluck(:id))
    new_bid_count = product_bids.count - (Rails.cache.fetch("#{current_user.id}/last_seen_bid_count") || 0)
    return new_bid_count
  end
end