# == Schema Information
#
# Table name: data_points
#
#  id         :integer          not null, primary key
#  dive_id    :integer
#  time       :integer
#  depth      :integer
#  temp       :integer
#  air        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DataPoint < ApplicationRecord
  belongs_to :dive
end
