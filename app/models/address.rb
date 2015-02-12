# == Schema Information
#
# Table name: addresses
#
#  id            :integer          not null, primary key
#  building_name :string
#  street        :string
#  po_box        :string
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  neighborhood  :integer
#
# 
# Legend 
# Neighborhoods:
# 
# 0: Kilimani
# 1: Lavington
# 2: Westlands
# 3: CBD
# 4: Upperhill
# 5: Karen
# 6: Runda
# 7: Eastlands

class Address < ActiveRecord::Base
	has_many :appointments
	belongs_to :user

	validates_presence_of :building_name, :street, :neighborhood, :user_id
end
