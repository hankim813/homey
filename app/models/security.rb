# == Schema Information
#
# Table name: securities
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Security < ActiveRecord::Base
	has_one :booking, as: :serviceable
	has_many :guards
end
