# == Schema Information
#
# Table name: car_washes
#
#  id             :integer          not null, primary key
#  cars           :integer
#  water_provided :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class CarWash < ActiveRecord::Base
	has_one :booking, as: :serviceable

	validates_presence_of :cars
	validates_inclusion_of :water_provided, in: [true, false]
end
