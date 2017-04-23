class CreateTips < ActiveRecord::Migration[5.0]
  def change
    create_table :tips do |t|
      t.integer :genre_id, null: false, default: 0, foreign_key: true
      t.text :title
      t.text :detail
      t.boolean :delete_flag
      t.datetime :created_at
      t.datetime :updated_at
      t.timestamps
    end
  end
end
