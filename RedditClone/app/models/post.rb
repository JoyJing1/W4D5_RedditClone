class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true

  has_many :post_subs, inverse_of: :post, dependent: :destroy
  has_many :subs, through: :post_subs, source: :sub
  has_many :comments, dependent: :destroy

  belongs_to :author, foreign_key: :author_id, class_name: "User"
end
