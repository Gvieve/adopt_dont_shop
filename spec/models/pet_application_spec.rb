require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it {should belong_to :application}
    it {should belong_to :pet}
  end
  #
  # it 'can have nil status' do
  #   @application.update!(status: :pending)
  #   expect(@application.status).to eq('pending')
  #   expect(@application.pending?).to eq(true)
  # end
  #
  # it 'can have approved status' do
  #   @application.update!(status: :pending)
  #   expect(@application.status).to eq('pending')
  #   expect(@application.pending?).to eq(true)
  # end
  #
  # it 'can have rejected status' do
  #   @application.update!(status: :accepted)
  #   expect(@application.status).to eq('accepted')
  #   expect(@application.accepted?).to eq(true)
  # end
end
