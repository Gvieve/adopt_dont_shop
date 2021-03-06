require 'rails_helper'

RSpec.describe "From the pet index page" do
  before :each do
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @shelter2 = Shelter.create!(name: "Silly Shelter", address: "123 Silly Ave", city: "Longmont", state: "CO", zip: 80012)
    @shelter3 = Shelter.create!(name: "Shell Shelter", address: "102 Shelter Dr.", city: "Commerce City", state: "CO", zip: 80022)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet3 = @shelter1.pets.create!(image:"", name: "Zeus", description: "dog", approximate_age: 4, sex: "male")
  end

  describe "I see a link to 'Start an Application'" do
    describe "when clicked it takes me to a new application page" do
      it "and I can create an application" do
        visit '/pets'
        click_link "Start an Application"

        expect(current_path).to eq("/pets/applications/new")

        fill_in "first_name", with: "Amber"
        fill_in "last_name", with: "Smith"
        fill_in "address", with: "234 E Cool Way"
        fill_in "city", with: "Denver"
        fill_in "state", with: "CO"
        fill_in "zip", with: "80210"

        click_button "Create Application"

        expect(current_path).not_to eq("/pets/applications/new")
        expect(page).to have_content("Amber Smith")
      end

      describe 'and I cannot create an application if' do
        it 'first name is empty' do
          visit '/pets'
          click_link "Start an Application"

          expect(current_path).to eq("/pets/applications/new")

          fill_in "last_name", with: "Smith"
          fill_in "address", with: "234 E Cool Way"
          fill_in "city", with: "Denver"
          fill_in "state", with: "CO"
          fill_in "zip", with: "80210"

          click_button "Create Application"

          expect(current_path).to eq("/pets/applications/new")
          expect(page).to have_content("First name can't be blank")
          expect(page).to have_button("Create Application")
        end

        it 'last name is empty' do
          visit '/pets'
          click_link "Start an Application"

          expect(current_path).to eq("/pets/applications/new")

          fill_in "first_name", with: "Amber"
          fill_in "address", with: "234 E Cool Way"
          fill_in "city", with: "Denver"
          fill_in "state", with: "CO"
          fill_in "zip", with: "80210"

          click_button "Create Application"

          expect(current_path).to eq("/pets/applications/new")
          expect(page).to have_content("Last name can't be blank")
          expect(page).to have_button("Create Application")
        end

        it 'address is empty' do
          visit '/pets'
          click_link "Start an Application"

          expect(current_path).to eq("/pets/applications/new")

          fill_in "first_name", with: "Amber"
          fill_in "last_name", with: "Smith"
          fill_in "city", with: "Denver"
          fill_in "state", with: "CO"
          fill_in "zip", with: "80210"

          click_button "Create Application"

          expect(current_path).to eq("/pets/applications/new")
          expect(page).to have_content("Address can't be blank")
          expect(page).to have_button("Create Application")
        end

        it 'city, state or zip is empty' do
          visit '/pets'
          click_link "Start an Application"

          expect(current_path).to eq("/pets/applications/new")

          fill_in "first_name", with: "Amber"
          fill_in "last_name", with: "Smith"
          fill_in "address", with: "234 E Cool Way"

          click_button "Create Application"

          expect(current_path).to eq("/pets/applications/new")
          expect(page).to have_content("City can't be blank")
          expect(page).to have_content("State can't be blank")
          expect(page).to have_content("Zip can't be blank")
          expect(page).to have_button("Create Application")
        end
      end
    end
  end
end
