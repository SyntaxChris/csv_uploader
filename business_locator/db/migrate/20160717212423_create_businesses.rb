class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
    	t.string :name
      	t.timestamps null: false
    end
  end
end

# columns: business name, address, city, state, postal code, country, latitude, longitude

