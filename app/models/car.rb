# == Schema Information
#
# Table name: cars
#
#  id         :integer          not null, primary key
#  driver_id  :integer
#  model      :string
#  wheel_type :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owned      :boolean
#

class Car < ActiveRecord::Base
	belongs_to :driver

	validates_presence_of :model, :driver_id, :wheel_type, :owned
end
