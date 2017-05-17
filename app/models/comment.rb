class Comment < ActiveRecord::Base
 belongs_to :user
 belongs_to :shop
 has_many :replies, foreign_key: :parent_id, class_name: 'Comment'
end
