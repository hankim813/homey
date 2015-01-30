# == Schema Information
#
# Table name: office_cleanings
#
#  id         :integer          not null, primary key
#  sqft       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  kitchen    :boolean
#

class OfficeCleaning < ActiveRecord::Base
	has_one :booking, as: :serviceable

	validates_inclusion_of :kitchen, in: [true, false]
	validates :sqft, numericality: { greater_than: 500}, presence: true
end
