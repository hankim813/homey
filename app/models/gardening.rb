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

  validates_presence_of :type
  validates :acres, numericality: { greater_than: 0.50 }, presence: true
end
