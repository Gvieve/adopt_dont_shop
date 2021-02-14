class ApplicationsController < ApplicationController
  def new
  end

  def create
    @application = Application.new(application_params)

    if @application.save
      redirect_to "/pets/applications/#{@application.id}"
    else
      flash[:errors] = @application.errors.full_messages
      render :new
    end
  end

  def show
    @application = Application.find(params[:id])
  end

  private

  def application_params
    params.permit(:first_name,
                  :last_name,
                  :address,
                  :city,
                  :state,
                  :zip,
                  :adoption_reason)
  end
end
