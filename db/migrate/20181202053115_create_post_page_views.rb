class CreatePostPageViews < ActiveRecord::Migration[5.2]
  def change
    create_table :post_page_views do |t|
      t.references :post, foreign_key: true, null: false
      t.integer :view_count, default: 0, null: false
      t.timestamps
    end
  end
end
