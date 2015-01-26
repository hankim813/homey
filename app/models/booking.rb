# == Schema Information
#
# Table name: bookings
#
#  id               :integer          not null, primary key
#  appointment_id   :integer
#  quote            :decimal(8, 2)
#  serviceable_id   :integer
#  serviceable_type :string
#  notes            :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  num_of_providers :integer
#

class Booking < ActiveRecord::Base
	belongs_to :appointment
	belongs_to :serviceable, polymorphic: true

	def service
		case serviceable_type
			when "HomeCleaning"
				service = HomeCleaning.find_by(id: serviceable_id)
			when "OfficeCleaning"
				service = OfficeCleaning.find_by(id: serviceable_id)
		end
	end
end
