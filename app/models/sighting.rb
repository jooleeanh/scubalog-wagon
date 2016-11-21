# TODO: "Must have dive, animal"

class Sighting < ApplicationRecord
  belongs_to :dive
  belongs_to :animal
end

# Table name: sightings
#  id         :integer          not null, primary key
#  dive_id    :integer
#  animal_id  :integer
