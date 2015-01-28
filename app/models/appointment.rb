# == Schema Information
#
# Table name: appointments
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  service_date :datetime
#  completed    :boolean          default("false")
#  paid         :boolean          default("false")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  canceled     :boolean          default("false")
#

class Appointment < ActiveRecord::Base
	belongs_to :user
	has_one :booking

	validates_presence_of :user_id, :service_date
	validates_inclusion_of :completed, :paid, :canceled, in: [true, false]
end
