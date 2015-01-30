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
# Field Legend
# type: { 0: Askari, 1: Bodyguard }

class Guard < ActiveRecord::Base
	belongs_to :security
  self.inheritance_column = nil 

  validates :hours_required, numericality: { greater_than: 6 }, presence: true
  validates_inclusion_of :type, in: [0,1], presence: true
  validates_presence_of :security_id
end
