class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates_presence_of :first_name, :last_name, :address, :city, :state, :zip
  validates :adoption_reason, length: {minimum: 15}, on: :update

  enum status: [:in_progress, :pending, :approved, :rejected]

  def has_pets?
    pets.count > 0
  end
end
