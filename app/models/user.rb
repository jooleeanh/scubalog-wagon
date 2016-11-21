# TODO:
  # "Must have email, password, location?"
  # "Certifications must match with array below"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :participations
  has_many :dives

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

# Table name: users
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  dob                    :datetime
#  gender                 :string
#  location               :string
#  latitude               :float
#  longitude              :float
#  diving_since           :integer
#  certifications         :string           default([]), is an

### Devise ###
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet

CERTIFICATIONS = [

  "open_water",
  "advanced_open_water",
  "master_diver",
  "boat_diving",
  "deep_diving",
  "night",
  "wreck_diving",
  "dry_suit_diving",
  "underwater_photography",
  "drift",

  "altitude_diving",
  "river",
  "ice",
  "cave",
  "cavern",

  "rescue",
  "navigation",
  "search_and_recovery",

  "nitrox",
  "equipment",
  "science_of_diving",
  "scientific_diving",

  "freediving",

  "advanced_nitrox",
  "sidemount",
  "scooter",
  "cpr",
  "o2",
  "rebreather",
  "trimix",
  "advanced_trimix",
  "deco_procedures",

  "dive_guide",
  "dive_instructor",
  "dive_instructor_trainer"
]
