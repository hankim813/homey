class OfficeCleaning < ActiveRecord::Base
	has_one :booking, as: :serviceable

	validates_presence_of :sqft
end
