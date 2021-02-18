class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  validates_presence_of :name, :description, :approximate_age, :sex

  validates :approximate_age, numericality: {
              greater_than_or_equal_to: 0
            }

  enum sex: [:female, :male]

  def self.search_by_name(query, application_id)
    if query.empty?
      where("adoptable = ?", true).where(
        "id not in (?)", (PetApplication.select(:pet_id).where(
        "application_id = #{application_id}")))
    else
      where(["lower(name) LIKE ?", "%#{query.downcase}%"]).where(
        "adoptable = ?", true).where(
        "id not in (?)", (PetApplication.select(:pet_id).where(
        "application_id = #{application_id}")))
    end
  end
end
