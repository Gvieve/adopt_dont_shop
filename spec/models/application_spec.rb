require 'rails_helper'

RSpec.describe Application, type: :model do
  before :each do
    Application.destroy_all
    @application = Application.create!(first_name: "Geni", last_name: "Nuebel",
    address: "123 Cool Way", city: "Denver", state: "CO", zip: "80210",
    adoption_reason: "I love pets and they love me!")
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

    it 'can have approved status' do
      @application.update!(status: :approved)
      expect(@application.status).to eq('approved')
      expect(@application.approved?).to eq(true)
    end

    it 'can have rejected status' do
      @application.update!(status: :rejected)
      expect(@application.status).to eq('rejected')
      expect(@application.rejected?).to eq(true)
    end
end
