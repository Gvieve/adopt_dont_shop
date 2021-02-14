require 'rails_helper'

describe Application, type: :model do
  before :each do
    # Shelter.destroy_all
    # Pet.destroy_all
    Application.destroy_all

    # @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    # @shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
    # @shelter3 = Shelter.create!(name: "Shell Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)
    # @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    # @pet2 = @shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    # @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
    @application = Application.create!(first_name: "Geni", last_name: "Nuebel",
    address: "123 Cool Way", city: "Denver", state: "CO", zip: "80210",
    adoption_reason: "I love pets and they love me!")
  end
  # describe 'relationships' do
  #   it { should belong_to :shelter }
  # end

  describe 'validations' do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :adoption_reason}
  end

    it 'is created as status of in_progress by default' do
      expect(@application.status).to eq('in_progress')
      expect(@application.in_progress?).to eq(true)
    end

    it 'can have pending status' do
      @application.update!(status: :pending)
      expect(@application.status).to eq('pending')
      expect(@application.pending?).to eq(true)
    end

    it 'can have accepted status' do
      @application.update!(status: :accepted)
      expect(@application.status).to eq('accepted')
      expect(@application.accepted?).to eq(true)
    end

    it 'can have rejected status' do
      @application.update!(status: :rejected)
      expect(@application.status).to eq('rejected')
      expect(@application.rejected?).to eq(true)
    end
end
