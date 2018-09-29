class CreateInquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :inquiries do |t|
      t.string :subject
      t.text :content
      t.integer :user_id
      t.integer :house_id

      t.timestamps
    end
    #add_foreign_key :inquiries, :users, column: :user_id, primary_key: :id
    #add_foreign_key :inquiries, :houses, column: :house_id, primary_key: :id
  end
end
