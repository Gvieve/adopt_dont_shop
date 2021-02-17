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

  def update_approval
    @pet_application = PetApplication.where(application_id: params[:application_id], pet_id: params[:pet_id])
    @application = Application.find(params[:application_id])

    @pet_application.update(status: params[:status])

    @application.update(status: :rejected) unless PetApplication.all_approved?(@application.id)

    if PetApplication.all_approved?(@application.id)
      @application.update(status: :approved)
      @application.adopt_all
    end
    # Add logic to reject pets on other applications if marked adoptable = false

    redirect_to "/admin/applications/#{@application.id}"
  end

  private

  def pet_application_params
    params.permit(:application_id, :pet_id, :status)
  end
end
