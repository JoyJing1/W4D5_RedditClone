class Comment < ActiveRecord::Base
  validates :author_id, :post_id, :content, presence: true

  belongs_to :author, class_name: :User, foreign_key: :author_id, inverse_of: :comments
  belongs_to :post, dependent: :destroy
  has_many :child_comments, class_name: :Comment, foreign_key: :parent_comment_id
end
