class Divesite < ApplicationRecord
  has_many :events
  has_many :dives
end
