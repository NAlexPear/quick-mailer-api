Rails.application.routes.draw do
  resources :messages do
    resources :errors do
    end
  end
end
