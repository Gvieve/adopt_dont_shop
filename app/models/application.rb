class Application < ApplicationRecord
  has_many :pet_applications

  validates_presence_of :first_name, :last_name, :address, :city, :state, :zip, :adoption_reason

  enum status: [:in_progress, :pending, :accepted, :rejected]
end
