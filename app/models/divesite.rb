# TODO:
  # "Must have name, location"
  # "Depths must be positive"
  # "Uniqueness on name?"

class Divesite < ApplicationRecord
  has_many :events
  has_many :dives
  has_many :sightings, through: :dives
  has_many :animals, through: :sightings
  has_many :users, through: :dives

  validates :name, presence: true
  # validates :location, presence: true # TODO: Reverse geocoding
  # validates :latitude, :longitude, presence: true
  validates :latitude, uniqueness: { scope: :longitude }
  geocoded_by :location
  after_validation :geocode, if: :location_changed?
end

# Table name: divesites
#  id         :integer          not null, primary key
#  name       :string
#  location   :string
#  longitude  :float
#  latitude   :float
#  diffulty   :string
#  max_depth  :float
#  avg_depth  :float
#  freshwater :boolean          default(FALSE)
