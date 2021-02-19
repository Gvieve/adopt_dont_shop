require 'rails_helper'

RSpec.describe "When I visit an admin shelters index page" do
  before :each do
    Shelter.destroy_all
    Pet.destroy_all
    Application.destroy_all

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
  end

  it 'it has all shelters that are a link to that shelters show page' do
    visit '/admin/shelters'

    within '.all-shelters' do
      expect(page).to have_link("Shady Shelter")
      expect(page).to have_link("Silly Shelter")
      expect(page).to have_link("Shell Shelter")
      expect(@shelter2.name).to appear_before(@shelter3.name)
      expect(@shelter3.name).to appear_before(@shelter1.name)
      click_link "Shady Shelter"
      expect(current_path).to eq("/admin/shelters/#{@shelter1.id}")
    end

  end

  it 'has a section for shelters with pending applications and each is a link' do
    visit '/admin/shelters'

    within '#pending-apps' do
      expect(page).to have_link("Shady Shelter")
      expect(page).to have_link("Silly Shelter")
      expect(page).to_not have_link("Shell Shelter")
      expect(@shelter1.name).to appear_before(@shelter2.name)
      click_link "Shady Shelter"
      expect(current_path).to eq("/admin/shelters/#{@shelter1.id}")
    end
  end
end
