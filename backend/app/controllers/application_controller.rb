class ApplicationController < ActionController::API
  include Pundit
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Mongoid::Errors::DocumentNotFound, with: :not_found

 private
   def user_not_authorized
     render nothing: true, status: :unauthorized
   end

   def not_found
     render nothing: true, status: :not_found
   end
end
