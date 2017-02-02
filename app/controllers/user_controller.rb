class UserController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  # Verifica email e imagen contra modelo
  def verify
    user = nil
    if params[:email] && params[:image]
      user = User.where(email: params[:email], image: params[:image]).first
    end
    response = user.blank? ? ['No Autorizado', :unauthorized] : ['OK', :ok]
    render :json => { :message => response[0] }, status: response[1]
  end

  # Obtiene los parametros de email e imagen y realiza llamada al servicio verify mediante la gema HTTParty
  def login
    response = ['No Autorizado', :unauthorized]
    if params[:email] && params[:image] && params[:user_agent]
      api_response = HTTParty.post(url_for(action: :verify, email: params[:email]),
                      :body => { 'image' => params[:image] }.to_json,
                      :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
      response = ['OK', :ok] if api_response.code == 200
    end
    render :json => { :message => response[0] }, status: response[1]
  end
end
