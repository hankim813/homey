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
# Legend
# 0: electrical
# 1: mechanical
# 2: plumbing
# 3: painting
# 4: other

class Contractor < ActiveRecord::Base
	has_one :booking, as: :serviceable
  self.inheritance_column = nil 

  validates_inclusion_of :type, in: [0,1,2,3,4], presence: true
  validates_presence_of :problem_frequency, :problem_description
end
