# TODO: "Must have user, event"

class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :user, uniqueness: {scope: :event}
end

# Table name: participations
#  id         :integer          not null, primary key
#  user_id    :integer
#  event_id   :integer
