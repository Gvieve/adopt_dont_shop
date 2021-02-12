class ShelterPetsController < ApplicationController

  def index
    @shelter = Shelter.find(params[:shelter_id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    pet = @shelter.pets.new(shelter_pets_params)

    if pet.save
      redirect_to "/shelters/#{@shelter.id}/pets"
    else
      flash[:notice] = 'Pet not created: Required information missing.'
    end
  end

  private
  def shelter_pets_params
    params.permit(:image, :name, :description, :approximate_age, :sex, :adoptable)
  end

end
