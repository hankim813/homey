# == Schema Information
#
# Table name: addresses
#
#  id            :integer          not null, primary key
#  building_name :string
#  street        :string
#  po_box        :string
#  neighborhood  :string
#  phone         :string
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Address < ActiveRecord::Base
	has_many :appointments

	validates_presence_of :building_name, :street, :neighborhood, :user_id
end
