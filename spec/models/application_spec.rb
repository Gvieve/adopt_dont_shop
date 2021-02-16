require 'rails_helper'

RSpec.describe Application, type: :model do
  before :each do
    Shelter.destroy_all
    Pet.destroy_all
    Application.destroy_all
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter1.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
    @application1 = Application.create!(first_name: "Geni", last_name: "Nuebel",
    address: "123 Cool Way", city: "Denver", state: "CO", zip: "80210",
    adoption_reason: "I love pets and they love me!")
    @application2 = Application.create!(first_name: "Doris", last_name: "Yamamoto",
    address: "125 Amazing Cir", city: "Denver", state: "CO", zip: "80211",
    adoption_reason: "I love pets!")
  end

  describe 'relationships' do
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'validations' do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :adoption_reason}


    it 'is created as status of in_progress by default' do
      expect(@application1.status).to eq('in_progress')
      expect(@application1.in_progress?).to eq(true)
    end

    it 'can have pending status' do
      @application1.update!(status: :pending)
      expect(@application1.status).to eq('pending')
      expect(@application1.pending?).to eq(true)
    end

    it 'can have approved status' do
      @application1.update!(status: :approved)
      expect(@application1.status).to eq('approved')
      expect(@application1.approved?).to eq(true)
    end

    it 'can have rejected status' do
      @application1.update!(status: :rejected)
      expect(@application1.status).to eq('rejected')
      expect(@application1.rejected?).to eq(true)
    end
  end

  describe 'instance methods' do
    describe '#has_pets?' do
      it 'is true when an application has one or more pets' do
        @pet_application1 = PetApplication.create!(application: @application1, pet: @pet1)
        @pet_application2 = PetApplication.create!(application: @application2, pet: @pet2)
        @pet_application3 = PetApplication.create!(application: @application2, pet: @pet3)

        expect(@application1.has_pets?).to eq(true)
        expect(@application2.has_pets?).to eq(true)
      end

      it 'is false when an application exists but has no pets' do
        expect(@application1.has_pets?).to eq(false)
      end
    end
  end
end
