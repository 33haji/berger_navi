class AddDetailToShops < ActiveRecord::Migration[5.0]
  def change
    change_column :shops, :comment, :string
    add_column :shops, :detail, :text, :after => :comment
  end
end
