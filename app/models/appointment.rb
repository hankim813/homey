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
#  address_id   :integer
#

class Appointment < ActiveRecord::Base
	belongs_to :user
	belongs_to :address
	has_one :booking
	has_many :assignments
	has_many :service_providers, through: :assignments

	validates_presence_of :user_id, :service_date, :address_id
	validates_inclusion_of :completed, :paid, :canceled, :assigned, in: [true, false]
end
