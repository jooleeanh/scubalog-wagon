class Event < ApplicationRecord
  belongs_to :divesite
  has_many :participations
end
