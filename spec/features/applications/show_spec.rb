require 'rails_helper'

RSpec.describe "When I visit an application show page" do
  before :each do
    Shelter.destroy_all
    Pet.destroy_all
    Application.destroy_all

    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
    @shelter3 = Shelter.create!(name: "Shell Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
    @application = Application.create!(first_name: "Geni", last_name: "Nuebel",
    address: "123 Cool Way", city: "Denver", state: "CO", zip: "80210")
  end

  it "I can see the application's attributes and status" do
    visit "/pets/applications/#{@application.id}"

    expect(page).to have_content("Geni Nuebel Application")
    expect(page).to have_content("Address: 123 Cool Way")
    expect(page).to have_content("Denver, CO 80210")
    expect(page).to have_content("Status: In Progress")
  end

  describe 'and if the application status is In Progress' do
    it 'I can search for pets by name' do
      visit "pets/applications/#{@application.id}"

      expect(page).to have_content("Status: In Progress")

      within('#search_bar') do
        expect(page).to have_content("Search for the pet(s) you wish to adopt")
        fill_in "query", with: "th"
        click_button "Find My Pet(s)"
        expect(current_path).to eq("/pets/applications/#{@application.id}")
      end
    end

    it 'I can add one or more pets to the application' do
      visit "pets/applications/#{@application.id}"
      fill_in "query", with: "th"
      click_button "Find My Pet(s)"

      within("div#pet-#{@pet1.id}") do
        expect(page).to have_content("Thor")
        click_button "Adopt this Pet", match: :first
      end

      within("#pets_to_adopt") do
        expect(page).to have_content("Thor")
        expect(page).not_to have_content("Athena")
      end
    end

    describe 'then submit application section appears' do
      it 'and I can enter an adoption reason and submit application for approval' do
        visit "pets/applications/#{@application.id}"
        fill_in "query", with: "th"
        click_button "Find My Pet(s)"

        within("div#pet-#{@pet1.id}") do
          expect(page).to have_content("Thor")
          click_button "Adopt this Pet", match: :first
        end

        fill_in "adoption_reason", with: "I love pets and they love me!"
        click_button "Submit Application"

        expect(current_path).to eq("/pets/applications/#{@application.id}")
        expect(page).to have_content("I love pets and they love me!")
        expect(page).to have_content("Status: Pending")
      end
    end
  end
end
