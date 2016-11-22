# TODO: "Must have dive, time and depth"

class DataPoint < ApplicationRecord
  belongs_to :dive, dependent: :destroy

  validates :time, :depth, presence: true
end

# Table name: data_points
#  id         :integer          not null, primary key
#  dive_id    :integer
#  time       :integer
#  depth      :integer
#  temp       :integer
#  air        :integer
