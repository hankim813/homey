# == Schema Information
#
# Table name: home_cleanings
#
#  id          :integer          not null, primary key
#  bedrooms    :integer
#  bathrooms   :integer
#  kitchens    :integer
#  livingrooms :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class HomeCleaning < ActiveRecord::Base
	has_one :booking, as: :serviceable
	has_one :laundry
end
