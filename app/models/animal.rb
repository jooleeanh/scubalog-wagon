
class Animal < ApplicationRecord
  has_many :sightings
end

# Table name: animals
#  id          :integer          not null, primary key
#  name        :string
#  image_url   :string
#  description :string
