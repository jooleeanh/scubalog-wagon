# TODO: "Must have divesite and datetime"

class Event < ApplicationRecord
  belongs_to :divesite
  has_many :participations
  validates :datetime, presence: true
end

# Table name: events
#  id          :integer          not null, primary key
#  divesite_id :integer
#  datetime    :datetime
