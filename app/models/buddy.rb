# TODO: "Must have user, dive"

class Buddy < ApplicationRecord
  belongs_to :user
  belongs_to :dive
end

# Table name: buddies
#  id         :integer          not null, primary key
#  user_id    :integer
#  dive_id    :integer
