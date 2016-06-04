class Sub < ActiveRecord::Base
  validates :title, :moderator_id, presence: true

  has_many :post_subs, inverse_of: :sub
  has_many :posts, through: :post_subs, source: :post
  belongs_to :moderator, class_name: :User, foreign_key: :moderator_id
end
