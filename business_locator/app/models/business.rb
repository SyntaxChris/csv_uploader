class Business < ActiveRecord::Base
	has_many :locations
	accepts_nested_attributes_for :locations, allow_destroy: true

	def name_check(businesses)
		names = []
		businesses.each do |business|
			names << business[0]
		end
		names.uniq.length != 1
	end

	def add_locations(list)
		list.each do |loc|
			self.locations << Location.new(
	            address: loc[1], 
	            postal_code: loc[3], 
	            latitude: loc[6], 
	            longitude: loc[7]
	        )
		end
	end
end
