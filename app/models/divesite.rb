# TODO:
  # "Must have name, location"
  # "Depths must be positive"

class Divesite < ApplicationRecord
  has_many :events
  has_many :dives
  has_many :sightings, through: :dives
  has_many :animals, through: :sightings
  has_many :users, through: :dives
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
