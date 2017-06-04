class CreateShopsGenreTags < ActiveRecord::Migration[5.0]
  def change
    create_table :shops_genre_tags do |t|
      t.integer :shop_id, null: false, default: 0, foreign_key: true
      t.integer :genre_tag_id, null: false, default: 0, foreign_key: true
      t.timestamps
    end
  end
end
