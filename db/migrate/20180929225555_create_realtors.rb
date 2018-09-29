class CreateRealtors < ActiveRecord::Migration[5.2]
  def change
    create_table :realtors do |t|
      t.string :first_name
      t.string :last_name
      t.integer :company_id
      t.integer :phone_number
      t.integer :user_id

      t.timestamps
    end
    #add_foreign_key :realtors, :users, column: :user_id, primary_key: :id
    #add_foreign_key :realtors, :companies, column: :company_id, primary_key: :id
  end
end
