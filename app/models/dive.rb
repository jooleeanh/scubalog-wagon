# TODO:
# "Must have user, divesite, datetime."
# "Type must belong to array (can be implemented later)"
# "Depths must be positive"
# "Enjoyment must be between 0 and 5"

class Dive < ApplicationRecord
  belongs_to :user
  belongs_to :divesite
  has_many :sightings
  has_many :data_points
end

# Table name: dives
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

TYPES = [
  "shore",
  "boat",
  "reef",
  "deep",
  "wall",
  "drift",
  "night",
  "lake",
  "muck",
  "wreck",
  "cave",
  "cenote",
  "cavern",
  "twilight",
  "shark",
  "seal",
  "scallop",
  "lobster",
  "nitrox"
]
