# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  divesite_id :integer
#  datetime    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Event < ApplicationRecord
  belongs_to :divesite
  has_many :participations
end
