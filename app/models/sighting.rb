
class Sighting < ApplicationRecord
  belongs_to :dive
  belongs_to :animal
  validates :dive, uniqueness: { scope: :animal }
end

# Table name: sightings
#  id         :integer          not null, primary key
#  dive_id    :integer
#  animal_id  :integer
