class UserController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  # Verifica email e imagen contra modelo
  def verify
    user = User.where(email: params[:email], image: params[:image]).first
    response = user.blank? ? ['No Autorizado', :unauthorized] : ['OK', :ok]
    render :json => { :message => response[0] }, status: response[1]
  end

  # Obtiene los parametros de email e imagen y realiza llamada al servicio verify mediante la gema HTTParty
  def login
    base_url = 'http://localhost:3000/rest'
    api_response = HTTParty.post("#{base_url}/verify_user/#{params[:email]}",
                      :body => { 'image' => params[:image] }.to_json,
                      :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
    response = api_response.code == 401 ? ['No Autorizado', :unauthorized] : ['OK', :ok]
    render :json => { :message => response[0] }, status: response[1]
  end
end
