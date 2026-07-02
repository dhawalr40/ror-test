class ApplicationController < ActionController::API
  before_action :authenticate_request!

  private

  attr_reader :current_user

  # Runs on every request unless the controller explicitly skips it
  # (only Api::V1::AuthController#login does). Reads "Authorization:
  # Bearer <token>", decodes it, and loads the user — or halts with 401.
  def authenticate_request!
    token = request.headers["Authorization"]&.split(" ")&.last
    decoded = token && JsonWebToken.decode(token)
    @current_user = decoded && User.find_by(id: decoded[:user_id])

    render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
  end

  def authorize_admin!
    render json: { error: "Forbidden — admin role required" }, status: :forbidden unless current_user&.admin?
  end
end