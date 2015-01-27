# == Schema Information
#
# Table name: gardenings
#
#  id         :integer          not null, primary key
#  acres      :float
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Gardening < ActiveRecord::Base
	has_one :booking, as: :serviceable
  self.inheritance_column = nil 
end
