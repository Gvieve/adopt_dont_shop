class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  validates_presence_of :name, :description, :approximate_age, :sex

  validates :approximate_age, numericality: {
              greater_than_or_equal_to: 0
            }

  enum sex: [:female, :male]

  def self.search_by_name(query)
    # require "pry"; binding.pry
    if query.empty?
      where(adoptable: :true)
    else
      where(["lower(name) LIKE ? and adoptable = ?", "%#{query.downcase}%", true])
    end
  end
end
