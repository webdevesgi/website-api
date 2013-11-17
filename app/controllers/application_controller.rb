class ApplicationController < ActionController::API
  before_action :allow_cors

  def allow_cors
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE}.join(",")
    headers["Access-Control-Allow-Headers"] =
      %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")
  end

  def is_authenticated?
    access_token = params['access_token']
    if access_token
      @current_user = User.find_by_token access_token
      puts @current_user
      unless @current_user
        render_error 'Wrong credentials', 403
      end
    else
      render_error "'access_token' parameter is missing", 403
    end
  end

  def render_error(msg, code)
    render json: {error: msg}, status: code
  end
end
