class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.integer :company_id
      t.text :location
      t.string :area
      t.integer :year_built
      t.string :style
      t.integer :list_prize
      t.integer :floor_count
      t.boolean :basement
      t.string :owner_name

      t.timestamps
    end
    #add_foreign_key :houses, :companies, column: :company_id, primary_key: :id
  end
end
