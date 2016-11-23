# TODO:
# "Type must belong to array (can be implemented later)"
# "Depths must be positive"
# "Enjoyment must be between 0 and 5"

class Dive < ApplicationRecord

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

  belongs_to :user
  # TODO: set "divesite was removed from database" if divesite is destroyed
  belongs_to :divesite, optional: true
  has_many :sightings, dependent: :destroy
  has_many :data_points, dependent: :destroy
  has_many :buddies, dependent: :destroy
  # has_one :equipment_set, through: :user # TODO: do it
  has_many :animals, through: :sightings
  validates :divesite, presence: true, on: :create
  validates :datetime, presence: true
  validates :max_depth, inclusion: { in: 1...200 },
                        allow_nil: true
  validates :avg_depth, inclusion: { in: 1..200 },
                        allow_nil: true
  validates :enjoyment, numericality: { only_integer: true},
                        inclusion: { in: 0...5 },
                        allow_nil: true

end

# Table name: dives
#  id             :integer          not null, primary key
#  user_id        :integer
#  divesite_id    :integer
#  datetime       :datetime
#  types           :string
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
