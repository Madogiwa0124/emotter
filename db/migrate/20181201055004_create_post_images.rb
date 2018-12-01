class CreatePostImages < ActiveRecord::Migration[5.2]
  def change
    create_table :post_images do |t|
      t.references :post, foreign_key: true, null: false
      t.binary :image, null:false
      t.string :ctype, null:false
      t.timestamps
    end
  end
end
