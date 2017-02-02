class UserController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def verify
    user = User.where(email: params[:email], image: params[:image]).first
    response = user.blank? ? ['No Autorizado', :unauthorized] : ['OK', :ok]
    render :json => { :message => response[0] }, status: response[1]
  end
end
