require 'rails_helper'

RSpec.describe "When I visit an admin application show page" do
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
    adoption_reason: "I would make such a great pet owner. I love them!!!", status: :pending)
    @pet_app1 = PetApplication.create!(application: @application1, pet: @pet1)
    @pet_app2 = PetApplication.create!(application: @application1, pet: @pet2)
    @pet_app3 = PetApplication.create!(application: @application2, pet: @pet1)
    @pet_app4 = PetApplication.create!(application: @application3, pet: @pet3)
    @pet_app5 = PetApplication.create!(application: @application3, pet: @pet4)
  end

  it "I can see only that application's attributes and status" do
    visit "/admin/applications/#{@application1.id}"

    expect(page).to have_content("Geni Nuebel's Application")
    expect(page).to have_content("Status: Pending")
    expect(page).to have_content("Address: 123 Cool Way")
    expect(page).to have_content("Denver, CO 80210")
    expect(page).to have_content("I love pets and they love me!")
  end

  describe 'next to each pet there is button to approve or deny' do
    describe 'when all pets are approved' do
      it 'the application status changes to approved and those pets are no longer adoptable' do
        visit "/admin/applications/#{@application2.id}"
        click_button "Approve Pet for Adoption"

        expect(current_path).to eq("/admin/applications/#{@application2.id}")
        expect(page).to have_content("Status: Approved")
        expect(page).not_to have_button("Approve Pet for Adoption")
        expect(page).not_to have_button("Deny Pet for Adoption")
        @pet1.reload
        expect(@pet1.adoptable).to eq(false)
      end
    end
  end
end
