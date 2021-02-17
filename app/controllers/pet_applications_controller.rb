class PetApplicationsController < ApplicationController

  def create
    @pet_application = PetApplication.new(pet_application_params)

    if @pet_application.save
      redirect_to "/pets/applications/#{@pet_application.application_id}"
    else
      flash[:errors] = @application.errors.full_messages
      redirect_to "/pets/applications/#{@pet_application.application_id}"
    end
  end

  private

  def pet_application_params
    params.permit(:application_id, :pet_id, :status)
  end
end
