class ApplicationsController < ApplicationController
  def new
    @application = Application.new
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

  def submit
    application = Application.find(params[:id])
    params[:status] = :pending
    application.update!(application_params)

    redirect_to "/pets/applications/#{application.id}"
  end

  private

  def application_params
    params.permit(:first_name,
                  :last_name,
                  :address,
                  :city,
                  :state,
                  :zip,
                  :adoption_reason,
                  :status)
  end
end
