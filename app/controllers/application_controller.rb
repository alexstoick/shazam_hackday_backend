class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :fix_api_headers
  def fix_api_headers
    headers["Access-Control-Allow-Origin"]  = "*"
    head(:ok) if request.request_method == "OPTIONS"
  end
end
