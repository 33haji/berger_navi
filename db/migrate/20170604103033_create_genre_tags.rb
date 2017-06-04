class CreateGenreTags < ActiveRecord::Migration[5.0]
  def change
    create_table :genre_tags do |t|
      t.string :tag_name
      t.timestamps
    end
  end
end
