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
#  time_required    :float
#

class Booking < ActiveRecord::Base
	belongs_to :appointment
	belongs_to :serviceable, polymorphic: true

	validates :num_of_providers, numericality: { greater_than: 0 }, allow_nil: true, presence: true

	def service
		case serviceable_type
			when 'HomeCleaning'
				HomeCleaning.find_by(id: serviceable_id)
			when 'OfficeCleaning'
				OfficeCleaning.find_by(id: serviceable_id)
			when 'CarWash'
				CarWash.find_by(id: serviceable_id)
			when 'Driver'
				Driver.find_by(id: serviceable_id)
			when 'Security'
				Security.find_by(id: serviceable_id)
			when 'Chef'
				Chef.find_by(id: serviceable_id)
			when 'Gardening'
				Gardening.find_by(id: serviceable_id)
			when 'Contractor'
				Contractor.find_by(id: serviceable_id)
		end
	end

	def price
		return '%.2f' % quote unless quote.nil?
	end
end
