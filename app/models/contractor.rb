# == Schema Information
#
# Table name: contractors
#
#  id                  :integer          not null, primary key
#  type                :integer
#  problem_description :text
#  problem_frequency   :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Contractor < ActiveRecord::Base
	has_one :booking, as: :serviceable
  self.inheritance_column = nil 
end
