require 'rails_helper'

RSpec.describe Pet, type: :model do
  before :each do
    @shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
    @pet1 = @shelter.pets.create!(name: "Fluffy", approximate_age: 3, sex: :male, description: 'super cute dog')
    @pet2 = @shelter.pets.create!(name: "Mr. fluffy", approximate_age: 3, sex: :male, description: 'super cute rabbit')
    @pet3 = @shelter.pets.create!(name: "Floofy", approximate_age: 3, sex: :female, description: 'adorable cute dog')
    @pet4 = @shelter.pets.create!(name: "fluff", approximate_age: 3, sex: :female, description: 'super cute cat', adoptable: :false)
    @application = Application.create!(first_name: "Geni", last_name: "Nuebel",
    address: "123 Cool Way", city: "Denver", state: "CO", zip: "80210")
  end
  
  describe 'relationships' do
    it { should belong_to :shelter }
    it {should have_many :pet_applications}
    it {should have_many(:applications).through(:pet_applications)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :sex}
    it {should validate_numericality_of(:approximate_age).is_greater_than_or_equal_to(0)}

    it 'is created as adoptable by default' do
      expect(@pet1.adoptable).to eq(true)
    end

    it 'can be created as not adoptable' do
      expect(@pet4.adoptable).to eq(false)
    end

    it 'can be male' do
      expect(@pet2.sex).to eq('male')
      expect(@pet2.male?).to be(true)
      expect(@pet2.female?).to be(false)
    end

    it 'can be female' do
      expect(@pet3.sex).to eq('female')
      expect(@pet3.female?).to be(true)
      expect(@pet3.male?).to be(false)
    end
  end

  describe 'class methods' do
    describe '::search_by_name' do
      it 'returns results when given a string' do
        expect(Pet.search_by_name("FlUff", @application.id).first).to eq(@pet1)
        expect(Pet.search_by_name("fLuFF", @application.id).last).to eq(@pet2)
        expect(Pet.search_by_name("fLuFF", @application.id).count).to eq(2)
        expect(Pet.search_by_name("fluff", @application.id).include?(@pet3)).to eq(false)
      end

      it 'returns all results when given an empty string' do
        expect(Pet.search_by_name("", @application.id).first).to eq(@pet1)
        expect(Pet.search_by_name("", @application.id).count).to eq(3)
      end

      it 'does not return pets already associated to current application' do
        PetApplication.create!(application: @application, pet: @pet1)

        expect(Pet.search_by_name("", @application.id).include?(@pet1)).to eq(false)
        expect(Pet.search_by_name("", @application.id).first).to eq(@pet2)
        expect(Pet.search_by_name("fluFF", @application.id).last).to eq(@pet2)
      end
    end
  end
end
