class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :contact_email
      t.text :content
      t.boolean :read_flag, default: false
      t.timestamps
    end
  end
end
