class Post < ApplicationRecord
  acts_as_taggable
  has_many :images, class_name: 'PostImage'
  validates :title, presence: true
  validates :body, presence: true
  validates :thumbnail, presence: true
  validates :ctype, presence: true
  validates :images, length: { maximum: 4 }
end
