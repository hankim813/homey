# == Schema Information
#
# Table name: chefs
#
#  id           :integer          not null, primary key
#  cuisine      :string
#  serving_size :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Chef < ActiveRecord::Base
	has_one :booking, as: :serviceable
end
