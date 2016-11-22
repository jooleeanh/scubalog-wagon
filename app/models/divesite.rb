# TODO:
  # "Must have name, location"
  # "Depths must be positive"
  # "Uniqueness on name?"

class Divesite < ApplicationRecord
  has_many :events
  has_many :dives
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
