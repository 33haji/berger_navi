class CreateShops < ActiveRecord::Migration[5.0]
  def change
    create_table :shops do |t|
      t.string :name, null: false
      t.float :rate
      t.string :area
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :url
      t.text :comment
      t.string :image1
      t.string :image2
      t.string :image3
      t.boolean :delete_flag, default: false
      t.timestamps
    end
  end
end
