class CreateHousehunters < ActiveRecord::Migration[5.2]
  def change
    create_table :househunters do |t|
      t.string :first_name
      t.string :last_name
      t.integer :phone
      t.string :contact_method
      t.integer :user_id

      t.timestamps
    end
    #add_foreign_key :househunters, :users, column: :user_id, primary_key: :id
  end
end
