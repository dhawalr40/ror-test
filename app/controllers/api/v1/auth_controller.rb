module Api
  module V1
    class AuthController < ApplicationController
      # skip_before_action :authenticate_request, only: :login
      def login
        user = User.find_by(email: params[:email])
      end
    end
  end
end