class Dive < ApplicationRecord
  belongs_to :user
  belongs_to :divesite
  has_many :sightings
  has_many :data_points
end
