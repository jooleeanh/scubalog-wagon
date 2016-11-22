# TODO: "Must have divesite and datetime"

class Event < ApplicationRecord
  # TODO: set to "no locations yet" if divesite is destroyed
  belongs_to :divesite, optional: true
  has_many :participations
  validates :datetime, presence: true
end

# Table name: events
#  id          :integer          not null, primary key
#  divesite_id :integer
#  datetime    :datetime
