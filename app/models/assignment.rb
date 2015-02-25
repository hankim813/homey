class Assignment < ActiveRecord::Base
	belongs_to :appointment
	belongs_to :service_provider
end
