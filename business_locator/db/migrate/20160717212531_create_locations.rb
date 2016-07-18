class CreateLocations < ActiveRecord::Migration
	def change
		create_table :locations do |t|
			t.references :business, index: true, foreign_key: true
			t.timestamps null: false
			t.string :address
			t.string :city
			t.string :state
			t.string :postal_code
			t.string :country
			# scale indicates decimal places. We only need 9 as that is down to micron level 
			# latitude is -90 to 90 degrees, in addition to 9 decimal places precision is 11
			t.decimal :latitude,  :precision => 11, :scale => 9
			# longitude is -180 to 180 degrees, in addition to 9 decimal places precision is 12
			t.decimal :longitude, :precision => 12, :scale => 9
		end
	end
end
