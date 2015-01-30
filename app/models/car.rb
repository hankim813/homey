# == Schema Information
#
# Table name: cars
#
#  id           :integer          not null, primary key
#  model        :string
#  wheel_type   :integer
#  day_or_night :integer
#  owned        :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  hours        :integer
#  driver_id    :integer
#

# Field Lenged
# wheel_type: { 0: 2WD, 1: 4WD }
# day_or_night: { 0: Night, 1: Day }

class Car < ActiveRecord::Base
	belongs_to :driver

	validates_inclusion_of :wheel_type, :day_or_night, in: [0,1], presence: true
	validates_inclusion_of :owned, in: [true, false], presence: true
	validates_presence_of :model, :driver_id
	validates :hours, numericality: { greater_than: 3.00 }, presence: true
end
