class PostImage < ApplicationRecord
  belongs_to :post
  validates :image, presence: true
  validates :ctype, presence: true
end
