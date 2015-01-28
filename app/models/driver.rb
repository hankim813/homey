# == Schema Information
#
# Table name: drivers
#
#  id           :integer          not null, primary key
#  day_or_night :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Driver < ActiveRecord::Base
	has_one :booking, as: :serviceable
	has_many :cars

	validates_presence_of :day_or_night
end
