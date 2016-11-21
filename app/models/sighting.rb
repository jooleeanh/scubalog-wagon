class Sighting < ApplicationRecord
  belongs_to :dive
  belongs_to :animal
end
