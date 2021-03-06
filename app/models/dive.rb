# TODO:
# "Type must belong to array (can be implemented later)"
# "Depths must be positive"
# "Enjoyment must be between 0 and 5"

class Dive < ApplicationRecord

  TYPES = [

# selected icons >>>>
    "shark",
    "shore",
    "boat",
    "reef",
    "deep",
    "night",
# >>>>>>>>>>>>>
    "wall",
    "drift",
    "lake",
    "muck",
    "wreck",
    "cave",
    "cenote",
    "cavern",
    "twilight",
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
  has_attachments :photos, maximum: 5
  before_create :set_review_rating
  validates :divesite, presence: true, on: :create
  validates :datetime, presence: true
  validates :max_depth, inclusion: { in: 1...200 },
                        allow_nil: true
  validates :avg_depth, inclusion: { in: 1..200 },
                        allow_nil: true
  validates :enjoyment, numericality: { only_integer: true},
                        inclusion: { in: 1...6 },
                        allow_nil: true
  scope :recent, -> { order(datetime: :desc) }

  private

  def set_review_rating
    self.review_rating = self.enjoyment
  end
end

# Table name: dives
#  id             :integer          not null, primary key
#  user_id        :integer
#  divesite_id    :integer
#  datetime       :datetime
#  types          :string
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
