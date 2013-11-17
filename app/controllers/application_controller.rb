class ApplicationController < ActionController::API
  before_action :allow_cors
  before_action :is_an_authenticated_app?

  def allow_cors
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE}.join(",")
    headers["Access-Control-Allow-Headers"] =
      %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")
  end

  def is_an_authenticated_app?
    can_access = ENV['AUTHORIZED_APPS'].include? request.remote_host
    unless can_access
      render json: {error: 'This is not an authenticated app'}, status: 403
    end
  end
end
