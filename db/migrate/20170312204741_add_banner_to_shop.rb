class AddBannerToShop < ActiveRecord::Migration
  def up
    add_attachment :shops, :banner
  end

  def down
    remove_attachment :shops, :banner
  end
end
