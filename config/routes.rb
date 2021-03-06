Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "welcome#index"

  get "/shelters", to: "shelters#index"
  get "/shelters/new", to: "shelters#new"
  get "/shelters/:id", to: "shelters#show"
  delete "/shelters/:id", to: "shelters#destroy"
  post "/shelters", to: "shelters#create"
  get "/shelters/:id/edit", to: "shelters#edit"
  patch "/shelters/:id", to: "shelters#update"

  get "/pets", to: "pets#index"
  get "/pets/:id", to: "pets#show"
  get "/pets/:id/edit", to: "pets#edit"
  patch "/pets/:id", to: "pets#update"
  delete "/pets/:id", to: "pets#destroy"

  get "/shelters/:shelter_id/pets", to: "shelter_pets#index"
  get "/shelters/:shelter_id/pets/new", to: "shelter_pets#new"
  post "/shelters/:shelter_id/pets", to: "shelter_pets#create"
  get "/shelters/:id/pets/:id", to: "pets#show"

  get "/pets/applications/new", to: "applications#new", as: :applications_new
  post "/pets/applications/new", to: "applications#create"
  get "/pets/applications/:id", to: "applications#show", as: :applications_show
  patch "/pets/applications/:id", to: "applications#submit", as: :application_submit
  post "/pets/applications/pet_applications", to: "pet_applications#create", as: :pet_applications_create

  get '/admin/applications/:id', to: 'admins#show', as: :admin_show
  patch '/admin/applications/pet_applications', to: 'pet_applications#update_approval', as: :pet_applications_update
  get '/admin/shelters', to: 'admins#shelters_index'
  get '/admin/shelters/:id', to: 'admins#shelters_show'
end
