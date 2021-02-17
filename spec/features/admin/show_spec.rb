require 'rails_helper'

RSpec.describe "When I visit an admin application show page" do
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

  # describe 'I can see all applications when I click a link to one' do
    it "I can see only that application's attributes and status" do
      visit "/admin/applications/#{@application.id}"

      expect(page).to have_content("Geni Nuebel Application")
      expect(page).to have_content("Status: In Progress")
      expect(page).to have_content("Address: 123 Cool Way")
      expect(page).to have_content("Denver, CO 80210")
      expect(page).to have_content("Denver, CO 80210")
    end
  # end
end
