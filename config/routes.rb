Rails.application.routes.draw do
  get 'map/index'

  root 'map#index'
end
