# == Schema Information
#
# Table name: equipment_sets
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  mask       :string
#  snorkel    :string
#  fins       :string
#  wetsuit    :string
#  computer   :string
#  bcd        :string
#  regulator  :string
#  weight     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EquipmentSet < ApplicationRecord
  belongs_to :user
end
