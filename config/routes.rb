Rails.application.routes.draw do
  root "search#index"
  post 'search', to: 'search#search'
end
