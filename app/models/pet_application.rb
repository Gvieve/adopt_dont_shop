class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  enum status: [:approved, :rejected]

  def self.all_approved?(application_id)
    where(status: :approved, application_id: application_id).count ==
    where(application_id: application_id).count
  end
end
