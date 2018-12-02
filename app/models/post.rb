class Post < ApplicationRecord
  acts_as_taggable
  has_many :images, class_name: 'PostImage', dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true
  validates :thumbnail, presence: true
  validates :ctype, presence: true
  validates :images, length: { maximum: 4 }

  scope :search, ->(params) {
    search_by_keyword(params[:keyword]).search_by_tag(params[:tag])
  }
  scope :search_by_keyword, ->(keyword) {
    return all if keyword.blank?
    where('title LIKE ?', "%#{keyword}%")
  }
  scope :search_by_tag, ->(tag) {
    return all if tag.blank?
    tagged_with(tag)
  }
end
