# == Schema Information
#
# Table name: sightings
#
#  id         :integer          not null, primary key
#  dive_id    :integer
#  animal_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sighting < ApplicationRecord
  belongs_to :dive
  belongs_to :animal
end
