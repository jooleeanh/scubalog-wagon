# TODO: "Must have user, event"

class Participation < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :event, dependent: :destroy
end

# Table name: participations
#  id         :integer          not null, primary key
#  user_id    :integer
#  event_id   :integer
