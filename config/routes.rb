Service::Application.routes.draw do
  resources :users do
    collection do
      post 'authenticate'
    end
  end
end
