require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  before :each do
    @shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
    @pet1 = @shelter.pets.create!(name: "Fluffy", approximate_age: 3, sex: :male, description: 'super cute dog')
    @pet2 = @shelter.pets.create!(name: "Mr. fluffy", approximate_age: 3, sex: :male, description: 'super cute rabbit')
    @pet3 = @shelter.pets.create!(name: "Floofy", approximate_age: 3, sex: :female, description: 'adorable cute dog')
    @pet4 = @shelter.pets.create!(name: "fluff", approximate_age: 3, sex: :female, description: 'super cute cat', adoptable: :false)
    @application = Application.create!(first_name: "Geni", last_name: "Nuebel",
    address: "123 Cool Way", city: "Denver", state: "CO", zip: "80210")
    @pet_application1 = PetApplication.create!(application: @application, pet: @pet1)
  end

  describe 'relationships' do
    it {should belong_to :application}
    it {should belong_to :pet}
  end

  describe 'validations' do
    it 'status can be nil' do
      expect(@pet_application1.status).to be_nil
    end

    it 'status can be approved' do
      @pet_application1.update!(status: :approved)
      expect(@pet_application1.status).to eq('approved')
      expect(@pet_application1.approved?).to eq(true)
    end

    it 'status can be rejected' do
      @pet_application1.update!(status: :rejected)
      expect(@pet_application1.status).to eq('rejected')
      expect(@pet_application1.rejected?).to eq(true)
    end
  end

  describe 'class methods' do
    describe '::all_approved?' do
      it 'returns true when all pets associated to application are approved' do
        pet_application2 = PetApplication.create!(application: @application, pet: @pet2)
        @pet_application1.update!(status: :approved)
        pet_application2.update!(status: :approved)

        expect(PetApplication.all_approved?(@application.id)).to eq(true)
      end

      it 'returns false when one or more pets associated to application are not approved' do
        pet_application2 = PetApplication.create!(application: @application, pet: @pet2)
        @pet_application1.update!(status: :approved)

        expect(PetApplication.all_approved?(@application.id)).to eq(false)
      end
    end
  end
end
