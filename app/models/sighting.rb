
class Sighting < ApplicationRecord
  belongs_to :dive, dependent: :destroy
  belongs_to :animal, dependent: :destroy
end

# Table name: sightings
#  id         :integer          not null, primary key
#  dive_id    :integer
#  animal_id  :integer
