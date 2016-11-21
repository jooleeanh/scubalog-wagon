# == Schema Information
#
# Table name: dives
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  divesite_id    :integer
#  datetime       :datetime
#  type           :string
#  tank_size      :integer
#  bottom_time    :integer
#  start_air      :integer
#  end_air        :integer
#  max_depth      :float
#  avg_depth      :float
#  min_temp       :float
#  max_temp       :float
#  comments       :text
#  enjoyment      :integer
#  visibility     :integer
#  polygon        :text             default([]), is an Array
#  review_rating  :integer
#  review_content :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Dive < ApplicationRecord
  belongs_to :user
  belongs_to :divesite
  has_many :sightings
  has_many :data_points
end
