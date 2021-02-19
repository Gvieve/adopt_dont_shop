class AdminsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def shelters_index
    @shelters = Shelter.sorted_by_name_desc
    @shelters_with_pending_apps = Shelter.with_pending_apps
  end

  def shelters_show
    @shelter = Shelter.find(params[:id])
  end
end
