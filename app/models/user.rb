# TODO:
  # "Must have email, password, location?"
  # "Certifications must match with yml"

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
