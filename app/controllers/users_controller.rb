class UsersController < ApplicationController
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
    local_ip = UDPSocket.open {|s| s.connect("64.233.187.99", 1); s.addr.last}
    puts "*"*100
    puts local_ip
    puts request.remote_ip
    puts "*"*100
    auth = true
    if Rails.env.production? && local_ip != request.remote_ip
      auth = false
    end


    response = ['No Autorizado', :unauthorized]
    if params[:email] && params[:image] && params[:user_agent] && auth
      api_response = HTTParty.post(url_for(action: :verify, email: params[:email]),
                      :body => { 'image' => params[:image] }.to_json,
                      :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
      response = ['OK', :ok] if api_response.code == 200
      EmailNotifierJob.perform_later(params[:email], response[0], params[:user_agent])
    end
    render :json => { :message => response[0] }, status: response[1]
  end
end
