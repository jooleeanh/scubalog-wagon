class Dive < ApplicationRecord
  belongs_to :user
  belongs_to :divesite
end
