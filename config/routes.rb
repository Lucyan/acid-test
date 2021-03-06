Rails.application.routes.draw do

  scope 'rest' do
    post 'verify_user/:email', to: 'users#verify', constraints: { email: /[^\/]+/ }
    post 'login', to: 'users#login'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
