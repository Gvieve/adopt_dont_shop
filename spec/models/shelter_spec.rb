require 'rails_helper'

describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many :pets }
  end

  describe 'class methods' do
    describe '::sorted_by_name_desc' do
      it 'returns all shelters sorted by name descending order' do
        @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
        @shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)

        expect(Shelter.sorted_by_name_desc.first.name).to eq("Silly Shelter")
        expect(Shelter.sorted_by_name_desc.last.name).to eq("Shady Shelter")
      end
    end

    describe '::get_name_and_address' do
      it 'returns address, city, state, zip for a shelter' do
        @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)

        expect(Shelter.get_name_and_address(@shelter1.id)).to eq("123 Shady Ave Denver CO 80011")
      end
    end

    describe '::with_pending_apps' do
      it 'returns a list of shelters that have pets with applications with a status of pending' do
        @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
        @shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
        @shelter3 = Shelter.create!(name: "Shell Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)
        @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "adorable dog", approximate_age: 2, sex: "male")
        @pet2 = @shelter2.pets.create!(image:"", name: "Athena", description: "super cute and sweet cat", approximate_age: 3, sex: "female")
        @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "loving dog", approximate_age: 4, sex: "male")
        @pet4 = @shelter2.pets.create!(name: "Mr. fluffy", approximate_age: 3, sex: :male, description: 'super cute rabbit')
        @application1 = Application.create!(first_name: "Geni", last_name: "Nuebel",
        address: "123 Cool Way", city: "Denver", state: "CO", zip: "80210",
        adoption_reason: "I love pets and they love me!", status: :pending)
        @application2 = Application.create!(first_name: "Doris", last_name: "Yamamoto",
        address: "125 Amazing Cir", city: "Denver", state: "CO", zip: "80211",
        adoption_reason: "I love pets so much and I just can't live without em!", status: :pending)
        @application3 = Application.create!(first_name: "Zach", last_name: "Nuebel",
        address: "234 Canyon Dr", city: "Boulder", state: "CO", zip: "80216",
        adoption_reason: "I would make such a great pet owner. I love them!!!")
        @pet_app1 = PetApplication.create!(application: @application1, pet: @pet1)
        @pet_app2 = PetApplication.create!(application: @application1, pet: @pet2)
        @pet_app3 = PetApplication.create!(application: @application2, pet: @pet1)
        @pet_app4 = PetApplication.create!(application: @application3, pet: @pet3)
        @pet_app5 = PetApplication.create!(application: @application3, pet: @pet4)

        expect(Shelter.with_pending_apps.first.name).to eq("Shady Shelter")
        expect(Shelter.with_pending_apps.last.name).to eq("Silly Shelter")
        expect(Shelter.with_pending_apps.include?(@shelter3)).to eq(false)
      end
    end

    describe 'instance methods' do
      it '#full_address' do
        @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)

        expect(@shelter1.full_address).to eq("123 Shady Ave Denver CO 80011")
      end
    end
  end
end
