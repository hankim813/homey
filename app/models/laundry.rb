# == Schema Information
#
# Table name: laundries
#
#  id               :integer          not null, primary key
#  loads            :integer
#  ironed           :integer
#  home_cleaning_id :integer
#

class Laundry < ActiveRecord::Base
	belongs_to :home_cleaning
end
