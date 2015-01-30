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

	validates :loads, :ironed, numericality: { greater_than: 0 }, presence: true
	valdiates_presence_of :home_cleaning_id
end
