# == Schema Information
#
# Table name: redemptions
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  discount_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Redemption < ActiveRecord::Base
	belongs_to :user
	belongs_to :discount
end
