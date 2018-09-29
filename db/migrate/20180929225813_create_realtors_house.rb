class CreateRealtorsHouse < ActiveRecord::Migration[5.2]
  def change
    create_table :realtors_houses do |t|
      t.integer :realtor_id
      t.integer :house_id
    end
    #add_foreign_key :realtors_houses, :realtors, column: :realtor_id, primary_key: :id
    #add_foreign_key :realtors_houses, :houses, column: :house_id, primary_key: :id
  end
end
