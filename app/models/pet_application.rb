class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  enum status: [:approved, :rejected]
end
