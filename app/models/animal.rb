# TODO: "Must have name"

class Animal < ApplicationRecord
  has_many :sightings, dependent: :destroy

  validates :name, presence: true

  scope :order_by_name, -> { order(name: :asc) }
end

# Table name: animals
#  id          :integer          not null, primary key
#  name        :string
#  image_url   :string
#  description :string
