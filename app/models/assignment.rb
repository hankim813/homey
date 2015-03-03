# == Schema Information
#
# Table name: assignments
#
#  id                  :integer          not null, primary key
#  service_provider_id :integer
#  appointment_id      :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Assignment < ActiveRecord::Base
	belongs_to :appointment
	belongs_to :service_provider
end
