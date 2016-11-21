# == Schema Information
#
# Table name: divesites
#
#  id         :integer          not null, primary key
#  name       :string
#  location   :string
#  longitude  :float
#  latitude   :float
#  diffulty   :string
#  max_depth  :float
#  avg_depth  :float
#  freshwater :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Divesite < ApplicationRecord
  has_many :events
  has_many :dives
end
