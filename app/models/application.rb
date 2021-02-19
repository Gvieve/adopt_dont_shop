class Application < ApplicationRecord
  has_many :pet_applications, :dependent => :destroy
  has_many :pets, through: :pet_applications

  validates_presence_of :first_name, :last_name, :address, :city, :state, :zip
  validates :adoption_reason, length: {minimum: 15}, on: :update

  enum status: [:in_progress, :pending, :approved, :rejected]

  def has_pets?
    pets.count > 0
  end

  def pet_application_status(pet)
    pet_applications.where(pet_id: pet.id).first.status
  end

  def adopt_all
    pets.each do |pet|
      pet.update(adoptable: false)
    end
  end

  def pet_adoptable?(pet_id)
    pets.find(pet_id).adoptable
  end
end
