# == Schema Information
#
# Table name: buddies
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  dive_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Buddy < ApplicationRecord
  belongs_to :user
  belongs_to :dive
end
