# == Schema Information
#
# Table name: guards
#
#  id             :integer          not null, primary key
#  security_id    :integer
#  type           :integer
#  hours_required :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Guard < ActiveRecord::Base
	belongs_to :security
  self.inheritance_column = nil 
end
