# == Schema Information
#
# Table name: discounts
#
#  id             :integer          not null, primary key
#  code           :string
#  percentage     :integer
#  times_redeemed :integer
#  admin_id       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  limit          :integer
#  reusable       :boolean
#

class Discount < ActiveRecord::Base
	belongs_to :admin
	has_many :redemptions

	validates :times_redeemed, :percentage, :limit, numericality: { greater_than_or_equal_to: 0 }, presence: true
	validates_inclusion_of :reusable, in: [true, false]
	validates_presence_of :code, :admin_id
end
