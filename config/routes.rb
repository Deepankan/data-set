Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '/upload_question_csv', to: 'questions#upload_question_csv', as: 'upload_question_csv', via: [:get, :post]
  match '/add_question', to: 'questions#add_question', as: 'add_question', via: [:get, :post]
  match '/update_question', to: 'questions#update_question', as: 'update_question', via: [:get, :put]

  get 'questions/edit_question', to: 'questions#edit_question'
  get 'questions/delete_question', to: 'questions#delete_question'

 # resources :questions

  root :to => 'questions#index'

  namespace :api, defaults: {format: 'json'} do
    get '/index' => 'questions#index'
    get '/edit_question' => 'questions#edit_question'
    post '/create_question' => 'questions#create_question'
    patch '/update_question' => 'questions#update_question'
    delete '/destroy_question' => 'questions#destroy_question'
  end
end
