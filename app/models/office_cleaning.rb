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

	validates_presence_of :sqft
end
