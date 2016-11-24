# TODO:
  # "Must have name, location"
  # "Depths must be positive"
  # "Uniqueness on name?"

class Divesite < ApplicationRecord
  has_many :events, dependent: :destroy # TODO: subject to change
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

  scope :order_by_name, -> { order(name: :asc) }

  def self.search(term)
    where('LOWER(name) ILIKE :term', term: "%#{term.downcase}%")
  end
end

# Table name: divesites
#  id         :integer          not null, primary key
#  name       :string
#  location   :string
#  longitude  :float
#  latitude   :float
#  difficulty   :string
#  max_depth  :float
#  avg_depth  :float
#  freshwater :boolean          default(FALSE)
