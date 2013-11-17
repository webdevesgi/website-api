class SessionsController < ApplicationController
  def auth
    user = params[:user] ? User.find_by(name: params[:user][:name]) : nil
    if user && user.authenticate(params[:user][:password])
      render json: { token: user.token}
    else
      render_error 'Wrong credentials', 403
    end
  end
end
