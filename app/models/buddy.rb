# TODO:
  # "Must have user, dive"
  # "Cannot be duplicated ?"

class Buddy < ApplicationRecord
  belongs_to :user
  belongs_to :dive
  validates :user, :dive, presence: true
  validates :user, uniqueness: { scope: :dive }
end

# Table name: buddies
#  id         :integer          not null, primary key
#  user_id    :integer
#  dive_id    :integer
