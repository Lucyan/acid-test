Rails.application.routes.draw do
  

  scope 'rest' do
    post 'verify_user/:email', to: 'user#verify', constraints: { email: /[^\/]+/ }
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
