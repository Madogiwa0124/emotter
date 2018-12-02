class Post < ApplicationRecord
  acts_as_taggable
  has_many :images, class_name: 'PostImage', dependent: :destroy
  has_one :page_view, class_name: 'PostPageView', dependent: :destroy
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

  def increment_page_view
    PostPageView.where(post_id: id)
                .first_or_initialize(post_id: id)
                .increment(:view_count, 1)
                .save
  end
end
