# TODO:
  # "Certifications must match with array below"
  # "Uniqueness on email?"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, omniauth_providers: [:facebook]


  has_many :participations, dependent: :destroy
  has_many :equipment_sets, dependent: :destroy
  has_many :dives, dependent: :destroy
  has_many :buddies, dependent: :destroy
  has_many :events, through: :participations
  has_many :sightings, through: :dives
  has_many :animals, through: :sightings

  validates :first_name, :last_name, :location, presence: true

  def self.find_for_facebook_oauth(auth)
    user_params = auth.to_h.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params[:location] = "Bordeaux"
    user = User.where(provider: auth.provider, uid: auth.uid).first
    user ||= User.where(email: auth.info.email).first # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation

      user.save
    end

    return user
  end
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
